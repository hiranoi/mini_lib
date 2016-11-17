class FeelingsController < ApplicationController
  #before_action :authenticate_user!

  # TODO:実装中
  def index
    @feelings = Feeling.all
    render :json => @feelings
  end

  def create
  	@feeling = Feeling.new()
  	@feeling.target = params[:target]
  	@feeling.target_id = params[:target_id]
  	@feeling.feeling = params[:feeling]

  	@feeling.save

  	render :json => "true"
  end
end
