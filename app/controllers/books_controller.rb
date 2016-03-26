class BooksController < ApplicationController
  before_action :authenticate_user!
  before_action :set_book, only: [:edit, :update, :destroy]

  def index
    @books = Book.all
  end

  def new
    @book = Book.new
  end

  def create
    @book = Book.new(book_params)
    @book.user_id = current_user.id

    inquiry = Book.inquiry_api(@book.isbn)
    @book.title = inquiry['//rss/channel/item/title'].text
    @book.author = inquiry['//rss/channel/item/author'].text.chop
    @book.publisher = inquiry['//rss/channel/item/dc:publisher'].text

    if @book.save
      redirect_to new_book_path, notice: 'book was successfully created.'
      #format.json { render :show, status: :created, location: @book }
    else
      render :new
      #format.json { render json: @book.errors, status: :unprocessable_entity }
    end
  end

  def show
    @book = Book.joins(:user).find(params[:id])
  end

  private

  def set_book
    @book = Book.find(params[:id])
  end

  def book_params
    params.require(:book).permit(:user_id, :title, :author, :publisher, :isbn)
  end
end
