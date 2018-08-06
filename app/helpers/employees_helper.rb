# frozen_string_literal: true

module EmployeesHelper
  def titleize(args)
    return [] unless args.is_a?(Array)
    args.map { |arg| [arg.titleize, arg] }
  end

  def leads
    @leads.map{ |lead| [lead.full_name, lead.id] }
  end
end
