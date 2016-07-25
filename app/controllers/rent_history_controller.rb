class RentHistoryController < ApplicationController
  before_action :authenticate_user!
  def index
    if view_context.user_admin?
      @rent_history = RentHistory.all.page(params[:page])
    else
      redirect_to books_path
    end
  end
end
