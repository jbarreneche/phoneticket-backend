ActiveAdmin.register Room do
  menu priority: 2
  actions :index, :show, :new, :create

  filter :theatre
  filter :name

  index do
    column :id
    column :theatre
    column :name
    column :shape do |room|
      human_shape(room.shape)
    end

    default_actions
  end

  show do |room|
    attributes_table do
      row :id
      row :theatre
      row :name
      row :shape do
        human_shape(room.shape)
      end
    end
  end

  form do |f|
    f.inputs "Información del administrador" do
      f.input :theatre
      f.input :name
      f.input :shape, collection: shapes_collection
    end
    f.actions
  end

  controller do
    def permitted_params
      params.permit room: [:theatre_id, :name, :shape]
    end
  end
end
