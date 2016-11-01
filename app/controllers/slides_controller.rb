class SlidesController < ApplicationController
  before_action :authenticate_user!
  
  def index
  	@slide = Slide.inquiry_slide_detail('http://www.slideshare.net/Ryuzee/scrum-8048905')


  end


  def new
	@slide = Slide.new
  end

  def create
  	
  end

end
