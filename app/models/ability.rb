class Ability
  include CanCan::Ability

  def initialize(user)
    can :read, Post, Public: true
    can :read, Comment, Public: true

    return unless user.present?

    can :read, :all

    return unless user.role == 'admin'

    can :manage, :all
  end
end
