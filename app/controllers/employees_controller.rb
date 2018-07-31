# frozen_string_literal: true

class EmployeesController < ApplicationController
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

  def edit
    @employee = Employee.find(params[:id])
  end

  def update
    @employee = Employee.find(params[:id])
    if @employee.update_attributes(employee_params)
      flash[:success] = 'Employee updated successfully'
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
end
