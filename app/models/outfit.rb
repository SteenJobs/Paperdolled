class Outfit < ActiveRecord::Base
  belongs_to :styled, :class_name => "User", :foreign_key => "styled_id"
  belongs_to :stylist, :class_name => "User", :foreign_key => "stylist_id"
  has_many :closets, dependent: :delete_all
  has_many :items, :through => :closets
end
