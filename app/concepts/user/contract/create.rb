require 'reform/form/validation/unique_validator'
module User::Contract
  class Create < Reform::Form
    include Sync::SkipUnchanged
    property :name
    property :email
    property :password
    property :password_confirmation, virtual: true
    property :role
    property :phone
    property :dob, as: :date
    property :address
    property :profile
    property :create_user_id
    property :updated_user_id

    validates :name, presence: true, length: { maximum: 100 }
    validates :email, presence: true, length: { maximum: 100 },
                      format: { with: Constants::VALID_EMAIL_REGEX },
                      unique: true
    validates :password, presence: true, confirmation: true
    validates :password_confirmation, presence: true
    validates :phone, numericality: true, length: { minimum: 10, maximum: 13 }, allow_blank: true
    validates :address, length: { maximum: 255 }
    validates :dob, format: { with: Constants::VALID_DATE_FORMAT }, allow_blank: true
  end
end
