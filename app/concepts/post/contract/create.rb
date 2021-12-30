module Post::Contract
  class Create < Reform::Form
    property :title
    property :description
    property :status
    property :create_user_id
    property :updated_user_id
    property :deleted_user_id
    
    validates  :title, presence: true
    validates  :description, presence: true, length: { minimum: 10 }
  end
end


