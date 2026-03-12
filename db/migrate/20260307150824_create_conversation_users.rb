class CreateConversationUsers < ActiveRecord::Migration[8.0]
  def change
    create_table :conversation_users do |t|
      t.references :conversation, null: false, foreign_key: true, index: true
      t.references :user, null: false, foreign_key: true, index: true
      t.index [:conversation_id, :user_id], unique: true
      t.timestamps
    end
  end
end
