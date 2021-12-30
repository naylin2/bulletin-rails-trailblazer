module User::Contract
  class Login < Reform::Form
    property :email
    property :password
    property :remember_me

    validates :email, presence: true
    validates :password, presence: true
  end
end
