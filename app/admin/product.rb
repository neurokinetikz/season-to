ActiveAdmin.register Product do
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
      f.input :vendor
      f.input :name
      f.input :description
      
    end
    
    f.inputs do
      f.has_many :images, :allow_destroy => true, :heading => 'Images', :new_record => true do |cf|
        cf.input :file, required: false
      end
    end

    f.inputs do
      f.has_many :skus, :allow_destroy => true, :heading => 'Skus', :new_record => true do |sf|
        sf.input :product
        sf.input :code
        sf.input :name
        sf.input :description
        sf.input :upc
        sf.input :vendor_code
        sf.input :unit_price

        sf.inputs do
        sf.has_many :images, :allow_destroy => true, :heading => 'Images', :new_record => true do |cf|
          cf.input :file, required: false
        end
      end
      end


    end

    f.actions
  end
  
  
  
end
