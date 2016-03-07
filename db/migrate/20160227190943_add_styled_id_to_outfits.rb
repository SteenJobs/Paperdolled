class AddStyledIdToOutfits < ActiveRecord::Migration
  def change
    add_column :outfits, :styled_id, :integer
  end
end
