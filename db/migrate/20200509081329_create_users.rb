class CreateUsers < ActiveRecord::Migration[6.0]
  def change
    create_table :users do |t|
      t.string :fname
      t.string :lname
      t.string :password_hash
      t.string :password_salt
      t.string :email
      t.string :role_name
      t.timestamps
    end
  end
end
