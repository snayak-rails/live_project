# frozen_string_literal: true

class EmployeesController < ApplicationController
  load_and_authorize_resource
  before_action :set_employee, except: %i[index new create]
  before_action :set_leads
  before_action :set_projects, :set_skills, only: %i[
    edit update create_employee_projects create_employee_skills
    edit_employee_skill edit_employee_project
  ]

  def index
    respond_to do |format|
      format.html
      format.json { render json: EmployeesDatatable.new(view_context) }
    end
  end

  def new
    @employee = Employee.new
  end

  def create
    @employee = Employee.new(employee_params)
    if @employee.save
      flash[:success] = 'Employee Saved successfully'
      redirect_to edit_employee_path @employee
    else
      render :new
    end
  end

  def edit; end

  def update
    if @employee.update_attributes(employee_params)
      flash[:success] = 'Employee updated successfully'
      redirect_to edit_employee_path @employee
    else
      render :edit
    end
  end

  def create_employee_projects
    @employee.employee_projects.create(
      employee_project_params[:employee_projects]
    )
    respond_to do |format|
      format.js { render layout: false }
    end
  end

  def create_employee_skills
    @employee.employee_skills.create(
      employee_skill_params[:employee_skills]
    )
    respond_to do |format|
      format.js { render layout: false }
    end
  end

  def edit_employee_project
    @employee_project = @employee.employee_projects.find(params[:project_id])
    respond_to do |format|
      format.js { render layout: false }
    end
  end

  def update_employee_project
    @employee_project = @employee.employee_projects.find(
      params[:employee][:employee_projects][:employee_project_id]
    )
    @employee_project.update_attributes(
      employee_project_params[:employee_projects]
    )
    respond_to do |format|
      format.js { render layout: false }
    end
  end

  def edit_employee_skill
    @employee_skill = @employee.employee_skills.find(params[:skill_id])
    respond_to do |format|
      format.js { render layout: false }
    end
  end

  def update_employee_skill
    @employee_skill = @employee.employee_skills.find(
      params[:employee][:employee_skills][:employee_skill_id]
    )
    @employee_skill.update_attributes(employee_skill_params[:employee_skills])
    respond_to do |format|
      format.js { render layout: false }
    end
  end

  private

  def employee_params
    params.require(:employee).permit(:first_name, :last_name,
                                     :email, :password, :password_confirmation,
                                     :grade, :lead_id,
                                     { experience: %i[year month] }, :salary,
                                     :engagement, :notes, :role, :location,
                                     :profile)
  end

  def employee_project_params
    params.require(:employee).permit(
      employee_projects: %i[project_id started_at is_current]
    )
  end

  def employee_skill_params
    params.require(:employee).permit(
      employee_skills: [:skill_id, experience: %i[year month]]
    )
  end

  def set_employee
    @employee = Employee.find(params[:id])
  end

  def set_leads
    @leads = Employee.reporting_managers
  end

  def set_projects
    @projects = Project.all
  end

  def set_skills
    @skills = Skill.all
  end
end
