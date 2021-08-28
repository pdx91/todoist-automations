class CreateAutomationEnableds < ActiveRecord::Migration[6.1]
  def change
    create_table :enabled_automations do |t|
      t.string :name
      t.belongs_to :user, index: true, foreign_key: true

      t.timestamps
    end
  end
end
