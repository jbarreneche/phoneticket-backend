class AddCoverToMovies < ActiveRecord::Migration
  def change
    add_column :movies, :cover, :string
  end
end
