class AddChatsUpdatedAtIndex < ActiveRecord::Migration[7.0]
  def change
    add_index :chats, :updated_at, using: :btree
  end
end
