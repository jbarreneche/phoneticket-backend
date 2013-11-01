require 'set'

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
    column(:available_seats) {|show| show.available_seats }
    column(:reserved_seats_count)  {|show| show.reserved_seats_count }
    column(:purchased_seats_count) {|show| show.purchased_seats_count }

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
      row :available_seats
      row :reserved_seats_count
      row :purchased_seats_count
      row :created_at
      row :updated_at
    end
    h2 "Estado de reservas y compras"

    render "room_status",
      shape: show.room.room_shape,
      reserved_places: Set.new(show.seats.reserved.pluck(:code)),
      purchased_places: Set.new(show.seats.purchased.pluck(:code))
  end

  controller do
    def permitted_params
      params.permit show: [
        :movie_id, :room_id, :starts_at
      ]
    end
  end

end
