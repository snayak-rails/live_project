# frozen_string_literal: true

class EmployeesController < ApplicationController
  before_action :set_employee, only: %i[edit update create_employee_projects]

  def index
    @employees = Employee.all
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
    @employee.employee_projects.build(
      employee_project_params[:employee_projects]
    )
    if @employee.save
      flash[:success] = 'Project Added successfully'
      redirect_to edit_employee_path @employee
    else
      render :edit
    end
  end

  private

  def employee_params
    params.require(:employee).permit(:first_name, :last_name,
                                     :email, :password, :password_confirmation,
                                     :grade,
                                     { experience: %i[year month] }, :salary,
                                     :engagement, :notes, :roles, :location,
                                     :is_admin)
  end

  def employee_project_params
    params.require(:employee).permit(
      employee_projects: %i[project_id started_at]
    )
  end

  def set_employee
    @employee = Employee.find(params[:id])
  end
end
