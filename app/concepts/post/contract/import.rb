module Post::Contract
  class Import < Reform::Form
    property :file, virtual: true

    validates :file, presence: true
    validate :check_header
    def check_header
      if (!errors[:file].any?)
        expected_header = Constants::POST_CSV_FORMAT_HEADER
        import_header = CSV.open(file, 'r', encoding:'iso-8859-1:utf-8') { |csv| csv.first }
        if import_header.size != expected_header.size 
          errors.add(:file, "Header is wrong.")
        else
          (0..import_header.size-1).each do |col_name|
            if (import_header[col_name] == nil || import_header[col_name].downcase != expected_header[col_name].downcase)
              errors.add(:file, "Header columns are wrong")
            end
          end
        end
      end
    end
  end
end
