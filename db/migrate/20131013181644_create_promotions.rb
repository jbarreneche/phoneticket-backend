class CreatePromotions < ActiveRecord::Migration
  def change
    create_table :promotions do |t|
      t.string :name
      t.date :starts_on
      t.date :ends_on
      t.string :discount_calculation_type
      t.integer :discount_n
      t.integer :discount_x
      t.integer :discount_percentage
      t.string :validation_type
      t.string :validation_code
      t.string :validation_bank

      t.timestamps
    end
  end
end
