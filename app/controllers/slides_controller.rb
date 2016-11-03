class SlidesController < ApplicationController
  before_action :authenticate_user!
  
  def index
  	@slides = Slide.all
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
    
    search_word = "スクラム"
    title = params[:title]

    if title.nil? || title.empty?
      render :json => nil
      return
    end

    mecab = Natto::MeCab.new
    logger.debug("********")
    mecab.parse(params[:title]) do |n|
        
        word = n.feature.split(",")
        if word[0] == "名詞"
          search_word = n.surface
          logger.debug(search_word)
          break;
        end

    end
    logger.debug("********")

    @slides = Slide.inquiry_slide_list(search_word)

    render :json => @slides
  end

end
