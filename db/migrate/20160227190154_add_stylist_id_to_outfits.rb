class AddStylistIdToOutfits < ActiveRecord::Migration
  def change
    add_column :outfits, :stylist_id, :integer
  end
end
