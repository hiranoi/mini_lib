class SlidesController < ApplicationController
  before_action :authenticate_user!
  
  def index
  	@slides = Slide.all
  end

  def new
	   @slide = Slide.new
  end

  def create
    url = params[:slide][:url]
  	@slide = Slide.inquiry_slide_detail(url)

    if @slide.save
        redirect_to new_slide_path, notice: 'スライドをを登録しました。'
    else
        render :new
    end
  end

end