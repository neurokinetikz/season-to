ActiveAdmin.register Sku do

  
  # See permitted parameters documentation:
  # https://github.com/gregbell/active_admin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # permit_params :list, :of, :attributes, :on, :model
  #
  # or
  #
  # permit_params do
  #  permitted = [:permitted, :attributes]
  #  permitted << :other if resource.something?
  #  permitted
  # end

  form do |f|
    f.inputs "Details" do
      f.input :product
      f.input :code
      f.input :name
      f.input :description
      f.input :upc
      f.input :vendor_code
      f.input :unit_price
    end
    
    f.inputs do
      f.has_many :images, :allow_destroy => true, :heading => 'Images', :new_record => true do |cf|
        cf.input :file, required: false
      end
    end

    f.actions
  end
  
end
