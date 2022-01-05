module User::Contract
  class UpdatePassword < Reform::Form
    include Sync::SkipUnchanged
    property :password
    property :password_confirmation, virtual: true
    property :old_password

    validates :password, presence: true, confirmation: true
    validates :password_confirmation, presence: true
    validates :old_password, presence: true
  end
end
