class Outfit < ActiveRecord::Base
  belongs_to :user
  has_many :closets, dependent: :destroy
  has_many :items, :through => :closets
end
