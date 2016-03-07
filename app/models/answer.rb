class Answer < ActiveRecord::Base
  belongs_to :scenario
  belongs_to :option
  
end
