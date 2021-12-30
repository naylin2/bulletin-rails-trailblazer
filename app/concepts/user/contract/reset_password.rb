module User::Contract
  class ResetPassword < Reform::Form
    property :email

    validates :email, presence: true
  end
end
