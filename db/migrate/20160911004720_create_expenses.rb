class CreateExpenses < ActiveRecord::Migration
  def change
    create_table :expenses do |t|
      t.belongs_to :user

      t.string :amount
      t.string :item
      t.string :location
      t.string :category

      t.timestamps null: false
    end
  end
end
