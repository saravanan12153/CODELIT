ActiveAdmin.register Cast do

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
    column :transcript
    column :slug
    column :publish
    column :video
    actions
  end
  form html: { multipart: true }  do |f|
    f.inputs  do
      f.input :title
      f.input :transcript
      f.input :slug
      f.input :publish
      f.input :video
    end
    f.actions
  end
  permit_params :list, :of, :attributes, :on, :model, :title, :transcript, :slug, :publish, :video
end
