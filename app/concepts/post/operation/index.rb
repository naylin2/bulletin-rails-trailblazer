module Post::Operation
    class Index < Trailblazer::Operation
        step :get_posts
        
        def get_posts(options, **)
            if options[:is_admin]
                options['posts'] = Post.all
            else
                options['posts'] = Post.where(create_user_id: options[:current_user].id)
            end
        end
    end
end