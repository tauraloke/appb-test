class RemoveChatIdFromMessageViewer < ActiveRecord::Migration[7.0]
  def change
    remove_column :message_viewers, :chat_id
  end
end
