class FeelingsController < ApplicationController
  before_action :authenticate_user!

  # TODO:実装中
  def index
    @feelings = Feeling.all
    render :json => @feelings
  end

  def create
  	@feeling = Feeling.new(feeling_params)
  end
end
