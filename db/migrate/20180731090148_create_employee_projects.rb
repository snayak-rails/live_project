class CreateEmployeeProjects < ActiveRecord::Migration[5.2]
  def change
    create_table :employee_projects do |t|
      t.references :employees, index: true
      t.references :projects, index: true
      t.datetime :started_at
      t.datetime :completed_at

      t.timestamps
    end
  end
end
