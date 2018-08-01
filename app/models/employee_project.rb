# frozen_string_literal: true

class EmployeeProject < ApplicationRecord
  belongs_to :employee
  belongs_to :project
end
