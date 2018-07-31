class CreateProjects < ActiveRecord::Migration[5.2]
  def change
    create_table :projects do |t|
      t.string :name, index: true, unique: true
      t.string :client_name
      t.string :category

      t.timestamps
    end
  end
end
