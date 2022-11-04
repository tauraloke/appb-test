class AddMessagesCreatedAtIndex < ActiveRecord::Migration[7.0]
  def change
    add_index :messages, :created_at, using: :btree
  end
end
