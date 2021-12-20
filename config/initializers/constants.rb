module Constants
    TYPES = {
        'Admin' => '0',
        'User' => '1'
    }
    VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
    HEADER = ["title", "description", "status"]
end