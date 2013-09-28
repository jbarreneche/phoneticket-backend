class AddMoreInfoToMovies < ActiveRecord::Migration
  def change
    change_table :movies do |t|
      t.text   :cast
      t.string :director
      t.string :country
      t.string :genre
      t.string :audience_rating
    end
  end
end
