class CreateReservations < ActiveRecord::Migration
  def change
    create_table :reservations do |t|
      t.references :show, index: true
      t.references :user, index: true
      t.references :purchase, index: true

      t.timestamps
    end
  end
end
