class Ability
  include CanCan::Ability

  def initialize(user)
    # Define abilities for the passed in user here. For example:
    #
    #   user ||= User.new # guest user (not logged in)
    #   if user.admin?
    #     can :manage, :all
    #   else
    #     can :read, :all
    #   end
    #
    # The first argument to `can` is the action you are giving the user 
    # permission to do.
    # If you pass :manage it will apply to every action. Other common actions
    # here are :read, :create, :update and :destroy.
    #
    # The second argument is the resource the user can perform the action on. 
    # If you pass :all it will apply to every resource. Otherwise pass a Ruby
    # class of the resource.
    #
    # The third argument is an optional hash of conditions to further filter the
    # objects.
    # For example, here the user can only update published articles.
    #
    #   can :update, Article, :published => true
    #
    # See the wiki for details:
    # https://github.com/ryanb/cancan/wiki/Defining-Abilities

    if user.blank?
      # not logged in
      cannot :manage, :all
      basic_read_only
    elsif user.has_role?(:admin)
      # admin
      can :manage, :all
    elsif user.has_role?(:client_manage)
      can :create, Client
      can :update, Client do |topic|
        (topic.user_id == user.id)
      end
      
      can :destroy, Client do |topic|
         (topic.user_id == user.id)
      end
      
      basic_read_only
    else
      # banned or unknown situation
      cannot :manage, :all
      basic_read_only
    end
  end

  protected

  def basic_read_only
    can :read,    Client
    can :list,    Client
    can :search,  Client    
  end
end
