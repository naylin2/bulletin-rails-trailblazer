# frozen_string_literal: true

module PostsHelper
  def self.check_header(expected_header, csv_file)
    header = CSV.open(csv_file, 'r', &:first)
    error_msg = ''
    (0..header.size - 1).each do |i|
      if header[i].downcase != expected_header[i].downcase
        error_msg = Messages::WRONG_HEADER
      elsif header.size != 3
        error_msg = Messages::WRONG_COLUMN
      end
    end
    error_msg
  end
end
