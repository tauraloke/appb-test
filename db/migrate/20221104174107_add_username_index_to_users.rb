class AddUsernameIndexToUsers < ActiveRecord::Migration[7.0]
  def change
    add_index :users, :username, using: :hash
  end
end