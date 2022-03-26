class CreateChatParticipants < ActiveRecord::Migration[7.0]
  def change
    create_table :chat_participants do |t|
      t.integer :user_id
      t.integer :chat_id
      t.integer :unread_messages_count, default: 0, null: false

      t.timestamps
    end
  end
end
