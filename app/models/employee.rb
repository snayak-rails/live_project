# frozen_string_literal: true

class Employee < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable,
         :recoverable, :rememberable, :trackable, :validatable

   ROLES =  [
    'super admin',
    'admin',
    'project manager',
    'lead',
    'mentor',
    'solution enginner'
   ]


  GRADES = [ 'A', 'B', 'C', 'D']

  ENGAGEMENTS = [ 'full time', 'partial' ]

  PROFILES = [
    'web developer',
    'mobile developer',
    'blockchain developer',
    'designer',
    'qa',
    'not applicable'
  ]


  LOCATIONS = %w[Indore-T61 Indore-CITP Pune].freeze

  ADMIN_ROLES = [ 'super admin', 'admin', 'project manager', 'lead', 'mentor']

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
