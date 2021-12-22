# frozen_string_literal: true

module Constants
  TYPES = {
    'Admin' => '0',
    'User' => '1'
  }.freeze
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
  HEADER = %w[title description status].freeze
end
