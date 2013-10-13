ActiveAdmin.register PriceSetting do
  menu false
  actions :edit, :update, :index

  form do |f|
    f.inputs f.object.name do
      f.input :adult
      f.input :kid
      f.input :discount_days, collection: discount_days_collection, multiple: true, as: :select
      f.input :adult_with_discount
      f.input :kid_with_discount
    end

    f.buttons
  end
  controller do
    def permitted_params
      params.permit price_setting: [:adult, :kid,
        :adult_with_discount, :kid_with_discount, discount_days: []]
    end
  end
end
