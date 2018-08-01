# frozen_string_literal: true

class CreateEmployeeSkills < ActiveRecord::Migration[5.2]
  def change
    create_table :employee_skills do |t|
      t.references :employee, index: true
      t.references :skill, index: true
      t.jsonb :experience, default: {}

      t.timestamps
    end
  end
end
