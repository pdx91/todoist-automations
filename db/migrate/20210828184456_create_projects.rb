class CreateProjects < ActiveRecord::Migration[6.1]
  def change
    create_table :projects do |t|
      t.string :name, null: false
      t.belongs_to :enabled_automation, foreign_key: true, index: true

      t.timestamps
    end
  end
end
