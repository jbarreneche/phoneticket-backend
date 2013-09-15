class AddDisableUser < ActiveRecord::Migration
  def change
    change_table :users do |t|
      t.boolean :disabled, default: false
    end
  end
end
