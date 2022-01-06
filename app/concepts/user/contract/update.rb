require 'reform/form/validation/unique_validator'
module User::Contract
  class Update < Reform::Form
  include Sync::SkipUnchanged
    property :name
    property :email
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
    validates :phone, numericality: true, allow_blank: true, length: { minimum: 10, maximum: 13 }
    validates :address, length: { maximum: 255 }, allow_blank: true
    validates :profile, length: { maximum: 255 }, allow_blank: true
    validates :dob, format: { with: Constants::VALID_DATE_FORMAT }, allow_blank: true
  end
end
