ActiveAdmin.register Book do
permit_params :title,:publisher,:isbn, :owner, :comments_count

index do
  selectable_column
  id_column
  column :title
  column :author
  column :publisher
  column :isbn
  column :owner
  column :comments_count
  actions
end

form do |f|
  f.inputs "Books Details" do
    f.input :user_id
    f.input :owner
    f.input :comments_count
  end
  f.actions
end
# See permitted parameters documentation:
# https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
#
# permit_params :list, :of, :attributes, :on, :model
#
# or
#
# permit_params do
#   permitted = [:permitted, :attributes]
#   permitted << :other if params[:action] == 'create' && current_user.admin?
#   permitted
# end


end
