module ReservationHelper

  def reservation_statuses_collection
    Hash[Reservation::STATUSES.map do |status|
      [human_reservation_status(status), status]
    end]
  end

  def human_reservation_status(status)
    I18n.t("reservation.statuses.#{status}", default: status.titleize) if status
  end
end
