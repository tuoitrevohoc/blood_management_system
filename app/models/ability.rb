class Ability
  include CanCan::Ability

  def initialize user
    user ||= User.new
    case user.role
    when "normal"
      can :read, :all
      can :manage, [Post, User], user_id: user.id
      can :manage, History, user_id: user.id, is_verified: false
    when "limited"
      can :manage, :all
      cannot :manage, [Place, User, Event]
      can :read, [Place, User, Event]
    when "admin"
      can :manage, :all
    else
      can :read, :all
    end
  end
end
