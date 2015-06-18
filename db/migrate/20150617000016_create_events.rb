class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.string :dress_me_for

      t.timestamps null: false
    end
  end
end
