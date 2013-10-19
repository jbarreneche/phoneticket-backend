class CreatePriceSettings < ActiveRecord::Migration
  def change
    create_table :price_settings do |t|
      t.string :name
      t.integer :adult
      t.integer :kid
      t.text :discount_days
      t.integer :adult_with_discount
      t.integer :kid_with_discount

      t.timestamps
    end
  end
end
