class CreateUsers < ActiveRecord::Migration[6.1]
  def change
    create_table :users do |t|

      t.string :name, unique: true, null: false
      t.string :email, unique: true, null: false
      t.text :password_digest, null: false
      t.string :profile, null: false, limit: 255
      t.string :type, null: false, limit: 1
      t.string :phone, limit: 20
      t.string :address, limit: 255
      t.date :dob
      t.integer :create_user_id, null: false
      t.integer :updated_user_id, null: false
      t.integer :deleted_user_id
      
      t.datetime :created_at, null: false
      t.datetime :updated_at, null: false
      t.datetime :deleted_at
    end
  end
end
