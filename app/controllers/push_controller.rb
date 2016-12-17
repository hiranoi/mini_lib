class PushController < ApplicationController

  def create

    @push = Push.send_news

    render :json => @push
  end

end
