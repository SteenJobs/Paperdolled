class AddEventLocationToUsers < ActiveRecord::Migration
  def change
    add_column :users, :event_location, :string
  end
end
