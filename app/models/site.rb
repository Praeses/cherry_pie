class Site < ActiveRecord::Base
  attr_accessible :name, :owner, :url

  has_many :pages

  belongs_to :home_page, :class_name => "Page", :foreign_key => 'home_page_id'

  after_create :setup_home_page

  private

  def setup_home_page
    self.home_page = Page.new
    self.home_page.site_id = self.id
    self.save!
  end

end
