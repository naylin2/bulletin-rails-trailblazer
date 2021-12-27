# frozen_string_literal: true

module Constants
  TYPES = {
    'Admin' => '0',
    'User' => '1'
  }.freeze
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
  POST_CSV_HEADER = %w[title description status]
  POST_CSV_FORMAT_HEADER = %w[title description status]
  VALID_DATE_FORMAT = /\d{4}-\d{2}-\d{2}/
end
