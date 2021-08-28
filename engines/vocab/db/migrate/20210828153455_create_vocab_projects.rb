class CreateVocabProjects < ActiveRecord::Migration[6.1]
  def change
    create_table :vocab_projects do |t|
      t.string :name, null: false
      t.bigint :resource_id, null: false
      t.bigint :user_id, null: false, foreign_key: true

      t.timestamps
    end
  end
end
