class AddLastResponseToUsers < ActiveRecord::Migration
  def change
    add_column :users, :last_response, :text
  end
end
