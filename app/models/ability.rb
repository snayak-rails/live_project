# frozen_string_literal: true

class Ability
  include CanCan::Ability

  def initialize(employee)
    # Define abilities for the passed in user here. For example:
    #
    #   user ||= User.new # guest user (not logged in)
    if employee.super_admin? || employee.admin?
      can :manage, :all
    elsif employee.project_manager?
      can :manage, Employee do |emp|
        (emp.projects & employee.projects).present?
      end

      cannot :manage, Employee, role: ['admin',
                                       'super_admin',
                                       'project manager']
    elsif employee.lead?
      can :manage, Employee, lead_id: employee.id
      cannot :manage, Employee, role: ['admin', 'super_admin',
                                       'project manager', 'lead']
    else
      can :manage, Employee, lead_id: employee.id
      cannot :manage, Employee, role: ['admin', 'super_admin',
                                       'project manager', 'lead', 'mentor']
    end
    can :manage, Employee, id: employee.id

    if employee.project_manager? || employee.lead? || employee.mentor?
      cannot :create, Employee
      can :read, Project
      can :read, Skill
    end
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
    # https://github.com/CanCanCommunity/cancancan/wiki/Defining-Abilities
  end
end
