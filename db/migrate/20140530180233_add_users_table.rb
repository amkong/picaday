class AddUsersTable < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :email, null: false
      t.string :encrypted_password, null: false, default: ""
      t.timestamps
    end
  end
end
