class ApiController < ApplicationController

  def index
  	# パラメータ取得
	isbn = params[:isbn]
	user_id = params[:user_id]

	# 初期化
	user = User.find(user_id)
    @book = Book.new()
    @book.user_id = user_id
    @book.owner = user.email

	# 国会API問い合わせ
    inquiry = Book.inquiry_api(isbn)
    @book.title = inquiry['//rss/channel/item/title'].text
    @book.author = inquiry['//rss/channel/item/author'].text.chop
    @book.publisher = inquiry['//rss/channel/item/dc:publisher'].text

	if @book.save
      render :json => {'text'=> '成功'}
    else
      render :json => {'text'=> '失敗'}
    end
  end

end