class Item < ActiveRecord::Base
  has_many :closets, dependent: :destroy
  has_many :outfits, :through => :closets
end
