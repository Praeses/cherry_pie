class Ability
  include CanCan::Ability

  def initialize(user)

    return if user.nil?

    #Praeses admin
    if user.class == Admin
      can :manage, :all
      return
    end

    can :manage, User if user.admin?

    can [:update, :destroy], Page do |page|
      user.admin? || page.owner == user
    end

  end
end
