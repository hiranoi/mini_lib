class SlideController < ApplicationController
  before_action :authenticate_user!
  
  def index
    

  	@slide = Slide.inquiry_slide_detail('http://www.slideshare.net/Ryuzee/scrum-8048905')


  end

end
