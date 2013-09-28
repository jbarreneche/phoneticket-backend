class CreateMovies < ActiveRecord::Migration
  def change
    create_table :movies do |t|
      t.string :title
      t.text :synopsis
      t.string :youtube_trailer

      t.timestamps
    end
  end
end
