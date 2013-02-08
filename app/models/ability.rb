class Ability
  include CanCan::Ability

  def initialize(user)

    return if user.nil?

    if user.class == Admin
      can :manage, :all
      return
    end

    can [:edit, :destroy], Page do |page|
      user.admin? || page.owner == user
    end

  end
end
