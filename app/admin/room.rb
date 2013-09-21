ActiveAdmin.register Room do
  menu priority: 2
  actions :index, :show

  filter :theatre
  filter :name

  index do
    column :id
    column :theatre
    column :name
    column :shape
    default_actions
  end


end
