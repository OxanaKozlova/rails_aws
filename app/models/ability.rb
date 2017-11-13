class Ability
  include CanCan::Ability

  def initialize(current_user)
    current_user ||= User.new
    if current_user.role?(User::ADMIN_ROLE)
      admin_ability
    elsif current_user.role?(User::MODERATOR_ROLE)
      moderator_ability(current_user)
    else
      user_ability(current_user)
    end
  end

  def moderator_ability(current_user)
    can :read, [User, Comment]
    can [:read, :manage], Post
    can :manage, [Comment], user_id: current_user.id
  end

  def admin_ability
    can :manage, :all
  end

  def user_ability(current_user)
    can :read, [User, Comment, Post]
    can :manage, [Comment, Post], user_id: current_user.id
  end

end
