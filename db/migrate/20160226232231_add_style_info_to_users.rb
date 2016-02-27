class AddStyleInfoToUsers < ActiveRecord::Migration
  def change
    add_column :users, :age, :string
    add_column :users, :style_likes, :string
    add_column :users, :style_dislikes, :string
    add_column :users, :style_icon, :string
  end
end
