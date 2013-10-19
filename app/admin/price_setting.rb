ActiveAdmin.register PriceSetting do
  menu false
  config.filters = false
  actions :edit, :update, :index

  index do
    column :name
    column(:adult) {|price| number_to_currency(price.adult) }
    column(:kid) {|price| number_to_currency(price.kid) }
    column(:discount_days) {|price| human_weekdays(price.discount_days).to_sentence }
    column(:adult_with_discount) {|price| number_to_currency(price.adult_with_discount) }
    column(:kid_with_discount) {|price| number_to_currency(price.kid_with_discount) }
    default_actions
  end

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
