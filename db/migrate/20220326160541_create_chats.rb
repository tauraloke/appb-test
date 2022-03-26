class CreateChats < ActiveRecord::Migration[7.0]
  def change
    create_table :chats do |t|
      t.string :title, null: true
      t.integer :last_message_id, null: true

      t.timestamps
    end
  end
end
