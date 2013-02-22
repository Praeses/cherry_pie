class Site < ActiveRecord::Base
  attr_accessible :name, :owner, :url

  has_many :pages

  belongs_to :home_page, :class_name => "Page", :foreign_key => 'home_page_id'
  belongs_to :users_page, :class_name => "Page", :foreign_key => 'users_page_id'

  after_create :setup_default_pages

  def display_name
    name || url
  end

  def href
    read_attribute(:href) || ( name ? "/pages/#{name}" : "/pages/#{id}" )
  end

  private

  def setup_default_pages
    self.home_page = Page.new
    self.home_page.site = self
    self.home_page.name = 'Home'
    self.home_page.href = '/'
    self.home_page.save!

    self.users_page = Page.new
    self.users_page.site = self
    self.users_page.field_objs << Field.new(:key => 'title', :value => "Teacher's Pages")
    self.users_page.name = 'Teachers'
    self.users_page.href = '/users'
    self.users_page.save!
    self.save!
  end

end
