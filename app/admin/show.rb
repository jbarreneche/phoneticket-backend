ActiveAdmin.register Show do
  menu priority: 2

  index do
    column :id
    column :movie
    column do |show|
      link_to show.room.to_label, admin_room_path(show.room)
    end
    column :starts_at
    default_actions
  end

  controller do
    def permitted_params
      params.permit show: [
        :movie_id, :room_id, :starts_at
      ]
    end
  end

end
