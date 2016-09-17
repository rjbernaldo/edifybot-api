class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :sender_id
      t.string :first_name
      t.string :last_name
      t.string :profile_pic
      t.string :locale
      t.string :timezone
      t.string :gender

      t.timestamps null: false
    end
  end
end
