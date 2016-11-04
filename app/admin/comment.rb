ActiveAdmin.register Comment do

  permit_params do
    permitted = [:user_id,:book_id,:comment]
  end

end
