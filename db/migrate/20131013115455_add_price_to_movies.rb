class AddPriceToMovies < ActiveRecord::Migration
  def change
    add_reference :movies, :price_setting, index: true
  end
end
