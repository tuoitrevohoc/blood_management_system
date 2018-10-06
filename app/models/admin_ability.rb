class AdminAbility
  include CanCan::Ability

  def initialize user
    case user.try :role
    when "normal"
      cannot :manage, :all
    when "limited"
      is_active = user.admin_histories.available.any?
      cannot :manage, :all
      can :manage, [Article, Event, Place]
      can :create, History do
        is_active
      end
      can :read, History do
        is_active
      end
    when "admin"
      can :manage, :all
      cannot [:update, :destroy], User, id: user.try(:id)
    else
      cannot :manage, :all
    end
  end
end
