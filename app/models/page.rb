class Page < ActiveRecord::Base
  belongs_to :site
  # attr_accessible :title, :body
end
