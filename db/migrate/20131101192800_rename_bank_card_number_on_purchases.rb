class RenameBankCardNumberOnPurchases < ActiveRecord::Migration
  def change
    rename_column(:purchases, "bank_card_number", "card_number")
  end
end
