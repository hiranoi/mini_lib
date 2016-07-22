class ApiController < ApplicationController

  def index
  	# パラメータ取得
	isbn = params[:isbn]
	user_id = params[:user_id]
  api_key = params[:api_key]

  # 入力チェック
  if !api_key.eql?("z6JnEVcS") || user_id.blank? || isbn.blank?
    render :json => {'text'=> '入力チェックエラー'}
    return
  end

	# ユーザー取得
	begin
    user = User.find(user_id)
  rescue
    render :json => {'text'=> 'ユーザーが存在しません'}
    return
  end    

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