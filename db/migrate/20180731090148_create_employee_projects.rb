# frozen_string_literal: true

class CreateEmployeeProjects < ActiveRecord::Migration[5.2]
  def change
    create_table :employee_projects do |t|
      t.references :employee, index: true
      t.references :project, index: true
      t.datetime :started_at
      t.datetime :completed_at
      t.boolean :is_current

      t.timestamps
    end
  end
end
