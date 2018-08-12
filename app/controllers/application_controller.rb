# frozen_string_literal: true

class ApplicationController < ActionController::Base
  before_action :authenticate_employee!

  rescue_from CanCan::AccessDenied do |exception|
    respond_to do |format|
      format.json { head :forbidden, content_type: 'text/html' }
      format.html { redirect_to main_app.root_url, alert: exception.message }
      format.js   { head :forbidden, content_type: 'text/html' }
    end
  end

  def current_ability
    @current_ability ||= Ability.new(current_employee)
  end
end
