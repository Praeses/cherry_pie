class Page < ActiveRecord::Base
  belongs_to :site
  has_many :fields

end
