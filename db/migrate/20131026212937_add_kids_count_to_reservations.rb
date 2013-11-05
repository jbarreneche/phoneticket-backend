class AddKidsCountToReservations < ActiveRecord::Migration
  def change
    add_column :reservations, :kids_count, :integer
    add_reference :reservations, :promotion, index: true
    add_column :reservations, :promotion_code, :string
    add_column :reservations, :bank_card_number, :string
  end
end
