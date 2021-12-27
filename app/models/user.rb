# frozen_string_literal: true

class User < ApplicationRecord
  belongs_to :created_user, class_name: 'User', foreign_key: 'create_user_id'
  belongs_to :updated_user, class_name: 'User', foreign_key: 'updated_user_id'

  # adds virtual attributes for authentication
  has_secure_password

  # soft-delete
  acts_as_paranoid

  # image
  has_one_attached :profile

  # to check old password with new password
  attr_accessor :old_password
end
