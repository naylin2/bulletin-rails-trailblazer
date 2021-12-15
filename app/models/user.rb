class User < ApplicationRecord
     # adds virtual attributes for authentication
     has_secure_password
     # validates email
     validates :email, presence: true, uniqueness: true, format: { with: /\A[^@\s]+@[^@\s]+\z/, message: 'Invalid email' }
     # soft-delete
     acts_as_paranoid
     # image
     has_one_attached :profile
end
