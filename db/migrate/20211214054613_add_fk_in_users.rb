# frozen_string_literal: true

class AddFkInUsers < ActiveRecord::Migration[6.1]
  def change
    add_foreign_key 'users', 'users', column: 'create_user_id'
    add_foreign_key 'users', 'users', column: 'updated_user_id'
  end
end
