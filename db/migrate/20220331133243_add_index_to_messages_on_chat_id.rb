class AddIndexToMessagesOnChatId < ActiveRecord::Migration[7.0]
  def change
    add_index :messages, :chat_id, unique: false, if_not_exists: true
  end
end
