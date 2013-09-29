class CreatePurchases < ActiveRecord::Migration
  def change
    create_table :purchases do |t|
      t.references :show, index: true
      t.references :user, index: true

      t.timestamps
    end
  end
end
