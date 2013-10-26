ActiveAdmin.register Show do
  menu priority: 2

  filter :movie
  filter :room
  filter :starts_at
  filter :created_at
  filter :updated_at

  index do
    column :id
    column :movie
    column :room do |show|
      link_to show.room.to_label, admin_room_path(show.room)
    end
    column :starts_at do |show|
      l show.starts_at, format: :short
    end
    bool_column(:numbered_seats)
    column(:available_seats_count) {|show| show.available_seats_count }
    column(:reserved_seats)  {|show| show.reserved_seats }
    column(:purchased_seats) {|show| show.purchased_seats }

    default_actions
  end

  show do |show|
    attributes_table do
      row :id
      row :movie
      row :room do
        link_to show.room.to_label, admin_room_path(show.room)
      end
      row :starts_at
      bool_row :numbered_seats
      row :available_seats_count
      row :reserved_seats
      row :purchased_seats
      row :created_at
      row :updated_at
    end
  end

  controller do
    def permitted_params
      params.permit show: [
        :movie_id, :room_id, :starts_at, :numbered_seats
      ]
    end
  end

end
