class AddAccessKeyToUsers < ActiveRecord::Migration
  def change
    add_column :users, :access_key, :string
    add_column :users, :access_count, :integer, null: false, default: 0
  end
end
