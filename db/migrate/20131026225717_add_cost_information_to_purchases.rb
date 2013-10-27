class AddCostInformationToPurchases < ActiveRecord::Migration
  def change
    add_column :purchases, :kids_count, :integer
    add_reference :purchases, :promotion, index: true
    add_column :purchases, :promotion_code, :string
    add_column :purchases, :bank_card_number, :string
    add_column :purchases, :payment_token, :string
    add_column :purchases, :payment_status, :string
    add_column :purchases, :total_cents, :integer
  end
end
