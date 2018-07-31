# frozen_string_literal: true

class Employee < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable,
         :recoverable, :rememberable, :trackable, :validatable

  enum role: {
    web_developer: 0,
    mobile_developer: 1,
    blockchain_developer: 2,
    lead: 3,
    designer: 4,
    qa: 5,
    tech_lead: 6,
    project_manager: 7
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

  LOCATIONS = %w[Indore-T61 Indore-CITP Pune].freeze

  protected

  def password_required?
    return false unless is_admin
    super
  end
end
