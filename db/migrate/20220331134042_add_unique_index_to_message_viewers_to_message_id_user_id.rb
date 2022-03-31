class AddUniqueIndexToMessageViewersToMessageIdUserId < ActiveRecord::Migration[7.0]
  def change
    add_index :message_viewers, [:message_id, :user_id], unique: true, if_not_exists: true
  end
end
