class AddDescriptionToPromotions < ActiveRecord::Migration
  def change
    add_column :promotions, :description, :text
  end
end
