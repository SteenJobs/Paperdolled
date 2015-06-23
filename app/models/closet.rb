class Closet < ActiveRecord::Base
  belongs_to :outfit
  belongs_to :item
end
