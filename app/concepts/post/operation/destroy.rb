module Post::Operation
  class Destroy < Trailblazer::Operation
    class Present < Trailblazer::Operation
      step Model(Post, :find_by)
      step Contract::Build(constant: Post::Contract::Destroy)
    end
    step Nested(Present)
    step :assign_current_user!
    step Contract::Validate()
    step Contract::Persist()
    step :delete!

    def assign_current_user!(options, **)
      options[:model][:deleted_user_id] = options['current_user'][:id]
    end

    def delete!(options, model:, **)
      model.destroy
    end
  end
end
