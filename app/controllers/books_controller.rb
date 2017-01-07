class BooksController < ApplicationController
  before_action :authenticate_user!
  before_action :set_book, only: [:edit, :update, :destroy]
  before_filter :set_search

  def index
    @books = @q.result(distinct: true).joins(:user).order('id DESC').page(params[:page]).per(20)
  end

  def new
    if view_context.user_admin?
      @book = Book.new
    else
      redirect_to books_path
    end
  end

  def create
    @book = Book.new(book_params)
    user = User.find(current_user.id)

    @book.user_id = current_user.id
    @book.owner = user.email

    # 国会図書館apiへの問い合わせ結果を格納
    @book = Book.inquiry_api(@book)

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
