class CreateMessageViewers < ActiveRecord::Migration[7.0]
  def change
    create_table :message_viewers do |t|
      t.integer :chat_id
      t.integer :message_id
      t.integer :user_id

      t.timestamps
    end
  end
end
