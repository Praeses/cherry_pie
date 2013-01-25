class Field < ActiveRecord::Base
  belongs_to :page
  attr_accessible :key, :value
end
