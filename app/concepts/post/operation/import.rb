module Post::Operation
  class Import < Trailblazer::Operation
    class Present < Trailblazer::Operation
      step Contract::Build(constant: Post::Contract::Import)
    end
    step Nested(Present)
    step Contract::Validate()
    step :import_csv!

    def import_csv!(options, params:, **)
      begin
        CSV.foreach(params[:file].path, headers: true, encoding:'iso-8859-1:utf-8', row_sep: :auto, header_converters: :symbol) do |row|
          Post.create! row.to_hash.merge(create_user_id: options['current_user_id'], updated_user_id: options['current_user_id'], created_at: Time.now, updated_at: Time.now)
        end
        return true
      rescue => exception
        return exception
      end
    end
  end
end
