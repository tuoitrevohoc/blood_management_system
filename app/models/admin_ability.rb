class AdminAbility
  include CanCan::Ability

  def initialize user
    case user&.role
    when "normal"
      cannot :manage, :all
    when "limited"
      cannot :manage, :all
      can :manage, [Article, Event, Place]
      can :create, History do
        user.admin_histories.available.any?
      end
    when "admin"
      can :manage, :all
      cannot [:update, :destroy], User, id: user&.id
    else
      cannot :manage, :all
    end
    cannot :update, History
  end
end
