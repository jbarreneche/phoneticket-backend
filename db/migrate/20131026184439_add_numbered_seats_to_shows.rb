class AddNumberedSeatsToShows < ActiveRecord::Migration
  def change
    add_column :shows, :numbered_seats, :boolean, default: true
  end
end
