class BooksController < ApplicationController
  before_action :authenticate_user!
  before_action :set_book, only: [:edit, :update, :destroy]
  before_filter :set_search

  def index
    @books = @q.result(distinct: true).joins(:user).order('id DESC').page(params[:page]).per(20)
  end

  def new
    @book = Book.new
  end

  def create
    @book = Book.new(book_params)
    user = User.find(current_user.id)

    @book.user_id = current_user.id
    @book.owner = user.email

    # 国会図書館apiへの問い合わせ結果を格納
    if !@book.isbn.nil?
      @book = Book.inquiry_api(@book)
    end

    if @book.save
      redirect_to new_book_path, notice: '図書を登録しました。'
    else
      render :new
    end

    rescue => e
      logger.info e
      redirect_to new_book_path, alert: '登録に失敗しました。'

  end

  def show
    @book = Book.joins(:user).find(params[:id])
    @comments = Comment.joins(:book, :user).where(book_id: params[:id]).order("created_at desc")
    @rent_histories = RentHistory.joins(:user).where(book_id: params[:id]).order("created_at desc")

    if @book.rent_user_id?
      @rent_user = User.find(@book.rent_user_id)
    end

    if !@book.image_url.nil?
      return
    end

    begin
      amazon_res = Amazon::Ecs.item_search(
        @book.title,
        search_index:'Books',
        dataType:'script',
        response_group:'ItemAttributes, Images',
        country:'jp',
        power:"Not kindle"
      )

      amazon_res.items.each do |item|
          @book.image_url = item.get('LargeImage/URL')
          @book.amazon_url = item.get('DetailPageURL')
          break;
      end
      @book.save
    rescue
    end
  end

  def destroy
    @book.destroy
    redirect_to books_path, notice: '図書を削除しました。'
  end

  def rent
    book = Book.find(params[:id])
    book.rent_user_id = current_user.id

    # 貸し出し履歴の保存
    rent_history = RentHistory.new
    rent_history.user_id = current_user.id
    rent_history.book_id = book.id

    if book.save && rent_history.save
      redirect_to book_path, notice: '貸出処理が完了しました。'
    else
      render :new
    end
  end

  def bring_back
    book = Book.find(params[:id])
    book.rent_user_id = nil

    if book.save
     redirect_to book_path, notice: '返却しました。'
    else
     render :new
    end
  end


  private

  def set_book
    @book = Book.find(params[:id])
  end

  def book_params
    params.require(:book).permit(:user_id, :title, :author, :publisher, :isbn)
  end

  def set_search
   @q = Book.search(params[:q])
  end
end
