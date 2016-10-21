ActiveAdmin.register User do

  permit_params do
    permitted = [:syoko, :place, :admin]
  end

end
