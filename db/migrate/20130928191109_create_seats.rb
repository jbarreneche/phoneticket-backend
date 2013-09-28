class CreateSeats < ActiveRecord::Migration
  def change
    create_table :seats do |t|
      t.string :code
      t.string :status
      t.references :show, index: true
      t.references :taken_by, index: true, polymorphic: true

      t.timestamps
    end
  end
end
