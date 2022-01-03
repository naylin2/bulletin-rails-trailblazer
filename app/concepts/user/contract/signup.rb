module User::Contract
  class Signup < Reform::Form
    include Sync::SkipUnchanged
    property :name
    property :email
    property :password
    property :password_confirmation, virtual: true

    validates :name, presence: true, length: { maximum: 100 }
    validates :email, presence: true, length: { maximum: 100 },
                      format: { with: Constants::VALID_EMAIL_REGEX },
                      unique: true
    validates :password, presence: true, confirmation: true
    validates :password_confirmation, presence: true
  end
end
