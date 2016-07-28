class RentHistoryController < ApplicationController
  before_action :authenticate_user!
  def index
    if view_context.user_admin?
      @rent_history = RentHistory.all.order('id DESC').page(params[:page])
    else
      redirect_to books_path
    end
  end
end
