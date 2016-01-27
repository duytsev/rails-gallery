class AddLoginAndAdminToUsers < ActiveRecord::Migration
  def change
    add_column :users, :login, :string
    add_index :users, :login, unique: true
    add_column :users, :admin, :boolean, default: false
  end
end
