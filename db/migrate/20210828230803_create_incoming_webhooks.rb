class CreateIncomingWebhooks < ActiveRecord::Migration[6.1]
  def change
    create_table :incoming_webhooks do |t|
      t.text :raw, null: false
      t.string :source, index: true, null: false
      t.boolean :processed, default: false, index: true
      t.belongs_to :user, foreign_key: true, index: true

      t.timestamps
    end
  end
end
