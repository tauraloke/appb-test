class AddUniqueIndexToChatParticipantsOnChatIdAndUserId < ActiveRecord::Migration[7.0]
  def change
    add_index :chat_participants, [:chat_id, :user_id], unique: true, if_not_exists: true
  end
end
