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

    can [:update], User do |usr|
      user.id == usr.id
    end

    can [:update], Site do |site|
      user.site.id == site.id
    end

    can [:update], Page do |page|
      user.admin? || (page.owner && page.owner.id == user.id)
    end

    can [:destroy], Page do |page|
      user.admin? && page.canDestroy
    end

    can :create, Page if user.admin?

  end
end
