class CreateRooms < ActiveRecord::Migration
  def change
    create_table :rooms do |t|
      t.references :theatre, index: true
      t.string :name
      t.string :shape

      t.timestamps
    end
  end
end
