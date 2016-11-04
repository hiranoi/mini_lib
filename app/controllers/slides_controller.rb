class SlidesController < ApplicationController
  before_action :authenticate_user!
  
  def index
  	@slides = Slide.all.order("created_at desc")
  end

  def show
    @slide = Slide.find(params[:id])
  end

  def new
	   @slide = Slide.new
  end

  def create
    url = params[:slide][:url]
  	@slide = Slide.inquiry_slide_detail(url)
    @slide.recommend_user = params[:slide][:recommend_user]
    @slide.recommend_comment =  params[:slide][:recommend_comment]

    if @slide.save
        redirect_to new_slide_path, notice: 'スライドをを登録しました。'
    else
        render :new
    end
  end

  def destroy
    @slide = Slide.find(params[:id])

    @slide.destroy
    redirect_to slides_path, notice: 'スライドを削除しました。'
  end

  def recommend
    
    # もともと形態素解析をいれていたがmecabの環境設定が大変なので一旦固定で
    # ゆくゆくはタグか何かで抽出できるとよい
    search_word = "スクラム"

    @slides = Slide.inquiry_slide_list(search_word)

    render :json => @slides[0,7]
  end

end
