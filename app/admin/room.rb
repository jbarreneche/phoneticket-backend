ActiveAdmin.register Room do
  menu priority: 2
  actions :index, :show

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

end
