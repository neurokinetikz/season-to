ActiveAdmin.register Vendor do

  form do |f|
    f.inputs "Details" do
      f.input :name
      f.input :description
      f.input :url
      f.input :phone
    end
    # f.inputs "Content" do
    #   f.input :body
    # end
    f.inputs do
      f.has_many :addresses, :allow_destroy => true, :heading => 'Address', :new_record => true do |cf|
        cf.input :first_name
        cf.input :last_name
        cf.input :address1
        cf.input :address2
        cf.input :city
        cf.input :state
        cf.input :zip
      end
    end
    f.actions
    end
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
  
end
