# frozen_string_literal: true

module ApplicationHelper
  def nav_class(controller, nav_name)
    controller.eql?(nav_name) ? 'nav-item nav-link active' : 'nav-item nav-link'
  end
end
