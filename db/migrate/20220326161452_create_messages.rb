class CreateMessages < ActiveRecord::Migration[7.0]
  def change
    create_table :messages do |t|
      t.integer :chat_id
      t.integer :user_id
      t.string :content

      t.timestamps
    end
  end
end
