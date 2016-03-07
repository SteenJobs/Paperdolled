class AddMoreColumnsToClosets < ActiveRecord::Migration
  def change
    add_column :closets, :width, :float
    add_column :closets, :height, :float
  end
end
