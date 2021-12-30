module Post::Operation
  class Create < Trailblazer::Operation
    class Present < Trailblazer::Operation
      step Model(Post, :new)
      step Contract::Build(constant: Post::Contract::Create)
    end
    step Nested(Present)
    step :assign_current_user!
    step Contract::Validate(key: :post)
    step Contract::Persist()

    def assign_current_user!(options, **)
      options[:params][:post][:status] = 1
      options[:params][:post][:create_user_id] = options['current_user'][:id]
      options[:params][:post][:updated_user_id] = options['current_user'][:id]
    end
  end
end
