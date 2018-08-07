# frozen_string_literal: true

class Employee < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable,
         :recoverable, :rememberable, :trackable, :validatable

  ROLES = [
    'super admin',
    'admin',
    'project manager',
    'lead',
    'mentor',
    'solution enginner'
  ].freeze

  GRADES = %w[A B C D].freeze

  ENGAGEMENTS = ['full time', 'partial'].freeze

  PROFILES = [
    'web developer',
    'mobile developer',
    'blockchain developer',
    'designer',
    'qa',
    'not applicable'
  ].freeze

  LOCATIONS = %w[Indore-T61 Indore-CITP Pune].freeze

  ADMIN_ROLES = ['super admin', 'admin', 'project manager', 'lead', 'mentor'].freeze

  # scopes

  scope :reporting_managers, -> { where(role: ADMIN_ROLES) }
  # relations

  has_many :employee_projects
  has_many :projects, through: :employee_projects

  has_many :employee_skills
  has_many :skills, through: :employee_skills

  belongs_to :lead, class_name: 'Employee', optional: true
  has_many :team_members, class_name: 'Employee', foreign_key: 'lead_id'

  # Validations
  validates :first_name, :last_name, presence: true
  validates :role, presence: true, inclusion: ROLES
  validates :engagement, inclusion: ENGAGEMENTS, unless: :super_admin?
  validates :profile, inclusion: PROFILES, unless: :super_admin?
  validates :location, presence: true, inclusion: LOCATIONS, unless: :super_admin?
  validates :salary, presence: true, unless: :super_admin?
  validates :lead_id, presence: true, if: :lead_required?

  def full_name
    "#{first_name} #{last_name}"
  end

  def current_projects
    employee_projects.where(is_current: true)
  end

  def current_project_names
    current_projects.map { |cp| cp.project.name }.join(', ')
  end

  def authorized_employee?
    ADMIN_ROLES.include?(role)
  end

  def skill_names
    employee_skills.map { |es| es.skill.name }.join(', ')
  end

  def humanize_experience
    "#{experience['year']}y #{experience['month']}m" if experience
  end

  protected

  def password_required?
    return false unless authorized_employee?
    super
  end

  def super_admin?
    return true if role.eql?('super admin')
  end

  def admin?
    return true if role.eql?('super admin')
  end

  def lead_required?
    return true unless super_admin? || admin?
  end
end
