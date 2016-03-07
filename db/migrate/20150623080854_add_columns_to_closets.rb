class AddColumnsToClosets < ActiveRecord::Migration
  def change
    add_column :closets, :x_coordinate, :float
    add_column :closets, :y_coordinate, :float
  end
end
