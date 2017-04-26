class Ability
  include CanCan::Ability

  def initialize user
    user ||= User.new
    case user.role
    when "normal"
      cannot :manage, :all
      can :read, :all
      can :read, User, is_public_profile: true
      can :manage, User, id: user.id
      can :read, [Post, History]
      can :manage, [Post, History], user_id: user.id
      can :read, Article, is_public: true
    when "limited"
      can :access, :ckeditor
      can [:read, :create, :destroy], Ckeditor::Picture
      can [:read, :create, :destroy], Ckeditor::AttachmentFile
      can :manage, :all
      cannot :manage, [Place, User, Event]
      can :read, [Place, User, Event]
    when "admin"
      can :access, :ckeditor
      can [:read, :create, :destroy], Ckeditor::Picture
      can [:read, :create, :destroy], Ckeditor::AttachmentFile
      can :manage, :all
    else
      cannot :manage, :all
      can :read, :all
      can :read, Article, is_public: true
    end
  end
end
