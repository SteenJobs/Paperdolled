class CreateItems < ActiveRecord::Migration
  def change
    create_table :items do |t|
      t.string :picture
      t.string :price
      t.string :name

      t.timestamps null: false
    end
  end
end
