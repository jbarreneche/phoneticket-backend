ActiveAdmin.register Reservation do
  menu priority: 2
  actions :index, :show

  filter :show_room_id_eq, as: :select, collection: Room.all
  filter :show_movie_id_eq, as: :select, collection: Movie.all
  filter :user_email, as: :string
  filter :show_starts_at, as: :date_range

  index do
    column :id
    column :show
    column :movie do |reservation|
      movie = reservation.show.movie
      link_to movie.title, admin_movie_path(movie)
    end
    column :starts_at do |reservation|
      l reservation.show.starts_at, format: :short
    end
    column :user

    default_actions
  end

  show do |reservation|
    attributes_table do
      row :id
      row :show
      row :starts_at do
        l reservation.show.starts_at, format: :short
      end
      row :seats do
        reservation.seats.to_sentence
      end
      row :user
      row :created_at
      row :updated_at
    end
  end

end
