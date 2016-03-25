class BooksController < ApplicationController
  def index
    @books = Book.joins(:user)
  end

  def new
    @book = Book.new
  end

  def create
    @book = current_user.Book.new(book_params)
    @book.user_id = current_user

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

  private

  def book_params
    params.require(:book).permit(:user_id, :title, :author, :publisher, :isbn)
  end
end
