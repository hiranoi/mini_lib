class RentHistoryController < ApplicationController
  def index
    @rent_history = RentHistory.all.page(params[:page])
  end
end
