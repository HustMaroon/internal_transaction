class AddAuthenticationColumnsToUsers < ActiveRecord::Migration[7.1]
  def change
    add_column :users, :email, :string, null: false
    add_column :users, :password_salt, :string, null: false
    add_index :users, :email, unique: true
  end
end
