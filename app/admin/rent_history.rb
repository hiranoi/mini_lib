ActiveAdmin.register RentHistory do

  permit_params do
    permitted = [:name,:book]
  end

end
