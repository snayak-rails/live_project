class CreateEmployeeSkills < ActiveRecord::Migration[5.2]
  def change
    create_table :employee_skills do |t|

      t.references :employees, index: true
      t.references :skills, index: true
      t.jsonb :experience, default: {}

      t.timestamps
    end
  end
end
