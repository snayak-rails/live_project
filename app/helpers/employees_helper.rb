# frozen_string_literal: true

module EmployeesHelper
  def titleize_keys(keys)
    keys.map { |key, _value| [key.humanize.titleize, key] }
  end
end
