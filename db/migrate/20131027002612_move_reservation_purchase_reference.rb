class MoveReservationPurchaseReference < ActiveRecord::Migration
  def change
    remove_reference :reservations, :purchase
    add_reference :purchases, :reservation, index: true
  end
end
