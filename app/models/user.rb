class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, #:registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me,
    :first_name, :last_name, :site_id
  # attr_accessible :title, :body

  belongs_to :site
  validates_presence_of :site, :first_name, :last_name


  def display_name
    return "#{first_name} #{last_name}" if first_name || last_name
    email
  end

end
