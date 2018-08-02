class Skill < ApplicationRecord
  has_many :employee_skills
  has_many :employees, through: :employee_skills
end
