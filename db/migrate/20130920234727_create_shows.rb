class CreateShows < ActiveRecord::Migration
  def change
    create_table :shows do |t|
      t.references :movie, index: true
      t.references :room, index: true
      t.datetime :starts_at

      t.timestamps
    end
  end
end
