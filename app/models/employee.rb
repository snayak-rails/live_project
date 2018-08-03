# frozen_string_literal: true

class Employee < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable,
         :recoverable, :rememberable, :trackable, :validatable

  enum role: {
    super_admin: 0,
    admin: 1,
    project_manager: 2,
    lead: 3,
    mentor: 4,
    solution_enginner: 5
  }

  enum grade: {
    a: 0,
    b: 1,
    c: 2,
    d: 3
  }

  enum engagement: {
    partial: 0,
    full_time: 1
  }

  enum profile: {
    web_developer: 0,
    mobile_developer: 1,
    blockchain_developer: 2,
    designer: 4,
    qa: 5,
    not_applicable: 6
  }

  LOCATIONS = %w[Indore-T61 Indore-CITP Pune].freeze
  ADMIN_ROLES = %w(super_admin admin project_manager lead mentor)

  # scopes

  scope :reporting_managers, -> { where(role: ADMIN_ROLES) }
  # relations

  has_many :employee_projects
  has_many :projects, through: :employee_projects

  has_many :employee_skills
  has_many :skills, through: :employee_skills

  def full_name
    "#{first_name} #{last_name}"
  end

  def current_projects
    employee_projects.where(is_current: true)
  end

  def current_project_names
    current_projects.map{ |cp| cp.project.name }.join(', ')
  end

  def authorized_employee?
    ADMIN_ROLES.include?(role)
  end

  def skill_names
    employee_skills.map{ |es| es.skill.name }.join(', ')
  end

  def humanize_experience
    "#{experience['year']}y #{experience['month']}m" if experience
  end

  protected

  def password_required?
    return false unless authorized_employee?
    super
  end
end
