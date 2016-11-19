class FeelingsController < ApplicationController
  #before_action :authenticate_user!

  # TODO:実装中
  def index
    @feelings = Feeling.all
    render :json => @feelings
  end

  def create
  	@feeling = Feeling.new()
  	@feeling.article_id = params[:article_id]
  	@feeling.user_id = current_user.id
	@feeling.feeling = "good"
  	@feeling.save

  	render :json => "true"
  end
end
