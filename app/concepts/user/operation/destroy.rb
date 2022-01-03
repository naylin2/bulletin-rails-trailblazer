module User::Operation
  class Destroy < Trailblazer::Operation
    step Model(User, :find_by)
    step :find_posts!
    step :delete!

    def find_posts!(options, model:, **)
      @posts = Post.where(create_user_id: options['model'][:id])
    end

    def delete!(options, model:, **)
      @posts.each do |post|
        post.destroy
      end
      model.destroy
    end
  end
end
