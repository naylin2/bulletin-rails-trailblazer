module User::Operation
  class Destroy < Trailblazer::Operation
    class Present < Trailblazer::Operation
      step Model(User, :find_by)
      step Contract::Build(constant: User::Contract::Destroy)
    end
    step Nested(Present)
    step :find_posts!
    step :assign_current_user!
    step Contract::Validate()
    step Contract::Persist()
    step :delete!

    def find_posts!(options, model:, **)
      @posts = Post.where(create_user_id: options['model'][:id])
    end

    def assign_current_user!(options, **)
      @posts.each do |post|
        # post.deleted_user_id = options['current_user'][:id]
        # post.update([:deleted_user_id])
        post.update_column :deleted_user_id, options['current_user'][:id]
      end
      options[:model][:deleted_user_id] = options['current_user'][:id]
    end

    def delete!(options, model:, **)
      model.destroy
    end
  end
end
