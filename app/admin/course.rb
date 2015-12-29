ActiveAdmin.register Course do

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
    column :subtitle
    column :promo
    column :publish
    actions
  end
  form html: { multipart: true }  do |f|
    f.inputs  do
      f.input :title
      f.input :subtitle
      f.input :promo
      f.input :description
      f.input :publish
      f.inputs "Attachment", :multipart => true do
        f.input :image, :as => :file
      end
    end
    f.actions
  end
  permit_params :list, :of, :attributes, :on, :model, :title, :subtitle, :promo, :description, :publish, :image
end
