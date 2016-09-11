class CreateExpenses < ActiveRecord::Migration
  def change
    create_table :expenses do |t|
      t.belongs_to :user

      t.timestamps null: false
    end
  end
end
