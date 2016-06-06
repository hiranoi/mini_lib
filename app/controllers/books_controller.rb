class BooksController < ApplicationController
  before_action :authenticate_user!
  before_action :set_book, only: [:edit, :update, :destroy]

  def index
    #@books = Book.joins(:user).all
    @books = Book.joins(:user).page(params[:page])
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
    @book.user_id = current_user.id

    inquiry = Book.inquiry_api(@book.isbn)
    @book.title = inquiry['//rss/channel/item/title'].text
    @book.author = inquiry['//rss/channel/item/author'].text.chop
    @book.publisher = inquiry['//rss/channel/item/dc:publisher'].text

    if @book.save
      redirect_to new_book_path, notice: '図書を登録しました。'
      #format.json { render :show, status: :created, location: @book }
    else
      render :new
      #format.json { render json: @book.errors, status: :unprocessable_entity }
    end

  rescue
    redirect_to new_book_path, alert: :unprocessable_entity
  end

  def show
    @book = Book.joins(:user).find(params[:id])
    @comments = Comment.joins(:book, :user).where(book_id: params[:id])
    #@users = User.all
  end

  def destroy
    @book.destroy
    redirect_to books_path, notice: '図書を削除しました。'
  end

  def edit
    @syoko = User.where(syoko: true)
  end

  def update
    respond_to do |format|
      if @book.update(book_params)
        format.html { redirect_to @book, notice: '返却処理が完了しました。' }
        format.json { render :show, status: :ok, location: @book }
      else
        format.html { render :edit }
        format.json { render json: @book.errors, status: :unprocessable_entity }
      end
    end
  end
#  def update
#    book = Book.find(params[:id])
#    book.user_id = current_user.id
#    if book.save
#      redirect_to book_path, notice: '所有者を変更しました。'
#      #format.json { render :show, status: :created, location: @book }
#    else
#      render :new
#      #format.json { render json: @book.errors, status: :unprocessable_entity }
#    end
#   end
  def rent
    book = Book.find(params[:id])
    book.user_id = current_user.id
    if book.save
      redirect_to book_path, notice: '貸出処理が完了しました。'
      #format.json { render :show, status: :created, location: @book }
    else
      render :new
      #format.json { render json: @book.errors, status: :unprocessable_entity }
    end
  end

  private

  def set_book
    @book = Book.find(params[:id])
  end

  def book_params
    params.require(:book).permit(:user_id, :title, :author, :publisher, :isbn)
  end
end
