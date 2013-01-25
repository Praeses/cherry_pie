class Site < ActiveRecord::Base
  attr_accessible :name, :owner, :url
end
