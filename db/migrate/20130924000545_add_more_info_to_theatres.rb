class AddMoreInfoToTheatres < ActiveRecord::Migration
  def change
    change_table :theatres do |t|
      t.text    :description
      t.string  :photo
      t.decimal :latitude, precision: 10, scale: 6
      t.decimal :longitude, precision: 10, scale: 6
      t.string  :address
    end
  end
end
