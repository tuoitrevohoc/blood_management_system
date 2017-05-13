class Ability
  include CanCan::Ability

  def initialize user
    case user&.role
    when "normal"
      can :read, :all
      can :read, [History, Place]
      can :manage, History, user_id: user.id
      can :manage, User, id: user.id
      can :manage, [:profile, :contract]
      cannot :manage, User, is_public_profile: false
      cannot :manage, [Event, Article], is_public: false
      cannot :manage, AdminHistory
    when "limited"
      can :access, :ckeditor
      can [:read, :create, :destroy], Ckeditor::Picture
      can [:read, :create, :destroy], Ckeditor::AttachmentFile
      can :manage, :all
    when "admin"
      can :access, :ckeditor
      can [:read, :create, :destroy], Ckeditor::Picture
      can [:read, :create, :destroy], Ckeditor::AttachmentFile
      can :manage, :all
    else
      cannot :manage, :all
      can :read, [Article, Event], is_public: true
    end
  end
end
