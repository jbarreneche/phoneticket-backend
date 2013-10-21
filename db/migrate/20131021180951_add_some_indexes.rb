class AddSomeIndexes < ActiveRecord::Migration
  def change
    add_index "reservations", ["user_id", "status"]
    add_index "shows", ["starts_at"]
  end
end
