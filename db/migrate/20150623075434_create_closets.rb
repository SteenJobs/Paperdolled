class CreateClosets < ActiveRecord::Migration
  def change
    create_table :closets, :id => false do |t|
      t.references :outfit, index: true, foreign_key: true
      t.references :item, index: true, foreign_key: true

      t.timestamps null: false
    end
    add_index :closets, [:outfit_id, :item_id], unique: true
  end
end
