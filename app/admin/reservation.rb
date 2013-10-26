ActiveAdmin.register Reservation do
  menu priority: 2
  actions :index, :show

  filter :status_eq, collection: ->(*) { reservation_statuses_collection }, as: :select
  filter :show_room_id_eq, as: :select, collection: Room.all
  filter :show_movie_id_eq, as: :select, collection: Movie.all
  filter :user_email, as: :string
  filter :show_starts_at, as: :date_range

  index do
    column :id
    column :status do |reservation|
      human_reservation_status(reservation.status)
    end
    column :show
    column :movie do |reservation|
      movie = reservation.show.movie
      link_to movie.title, admin_movie_path(movie)
    end
    column :starts_at do |reservation|
      l reservation.show.starts_at, format: :short
    end
    column :user

    actions do |reservation|
      links = raw('')
      links << link_to('Cancelar', cancel_admin_reservation_path(reservation), method: :put) if reservation.cancellable?
      links
    end
    # default_actions
  end

  show do |reservation|
    attributes_table do
      row :id
      row :status do
        human_reservation_status(reservation.status)
      end
      row :show
      row :promotion
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

  member_action :cancel, method: :put do
    reservation = Reservation.find(params[:id])
    if reservation.cancel!
      redirect_to :back, notice: I18n.t("admin.reservation.canceled")
    else
      redirect_to :back, error: reservation.errors.full_messages
    end
  end

  action_item only: [:show] do
    if reservation.cancellable?
      link_to('Cancelar', cancel_admin_reservation_path(reservation), method: :put)
    end
  end
end
