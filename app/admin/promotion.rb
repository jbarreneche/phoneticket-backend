ActiveAdmin.register Promotion do
  menu priority: 2

  filter :name
  filter :starts_on
  filter :ends_on

  index do
    column :id
    column :name
    column :starts_on
    column :ends_on
    column(:discount_calculation) {|movie| movie.discount_calculation.to_s }
    column(:validation_strategy)  {|movie| movie.validation_strategy.to_s }

    default_actions
  end

  show do |movie|
    attributes_table do
      row :id
      row :name
      row :description
      row :starts_on
      row :ends_on
      row(:discount_calculation) { movie.discount_calculation.to_s }
      row(:validation_strategy)  { movie.validation_strategy.to_s }
    end
  end

  form do |f|
    f.inputs "Promoción" do
      f.input :name
      f.input :description
      f.input :starts_on, as: :datepicker, input_html: { value: l(f.object.starts_on || Date.today) }
      f.input :ends_on, as: :datepicker, input_html: { value: l(f.object.ends_on || Date.today.at_end_of_month) }
      f.input :discount_calculation_type, collection: discount_calculation_types_collection
      f.input :discount_n
      f.input :discount_x
      f.input :discount_percentage
      f.input :validation_type, collection: validation_types_collection
      f.input :validation_bank, collection: %w[Galicia Santander\ Río HSBC ICBC]
      f.input :validation_code
    end

    f.buttons
  end


  controller do
    def permitted_params
      params.permit promotion: [
        :name, :description, :starts_on, :ends_on,
        :discount_calculation_type,
        :discount_n, :discount_x, :discount_percentage,
        :validation_type,
        :validation_bank, :validation_code
      ]
    end
  end

end
