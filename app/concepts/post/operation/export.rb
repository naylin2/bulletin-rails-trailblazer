require 'csv'
module Post::Operation::Export
  class CsvData < Trailblazer::Operation
    step :get_posts
    step :to_csv_text!

    def get_posts(options, **)
      options[:posts] = Post.all
    end

    def to_csv_text!(options, **)
      attributes = %w[title description status]
      options[:csv_text] =  CSV.generate(headers: true) do |csv|
                              csv << attributes
                              options[:posts].each do |post|
                                csv << attributes.map { |attr| post.send(attr) }
                              end
                            end
    end
  end
end
