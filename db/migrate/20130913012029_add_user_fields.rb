class AddUserFields < ActiveRecord::Migration
  def change
    change_table :users do |t|
      t.date   :date_of_birth
      t.string :document
      t.string :address
      t.index ["document"], name: "index_users_on_document", unique: true
    end
  end
end
