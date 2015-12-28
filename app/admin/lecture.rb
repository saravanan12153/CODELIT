ActiveAdmin.register Lecture do

# See permitted parameters documentation:
# https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
#
# permit_params :list, :of, :attributes, :on, :model
#
# or
#
# permit_params do
#   permitted = [:permitted, :attributes]
#   permitted << :other if resource.something?
#   permitted
# end

  index do
    id_column
    column :title
    column :video
    column :publish
    column :course
    actions
  end
  permit_params :list, :of, :attributes, :on, :model, :title, :video, :transcript, :external, :seq, :publish, :course_id


end
