# frozen_string_literal: true

module Post::Operation
    class Index < Trailblazer::Operation
      step :get_posts

      def get_posts(options, **)
        options['posts'] = if options[:is_admin]
                             Post.all
                           else
                             Post.where(create_user_id: options[:current_user].id)
                           end
      end
    end
  end
  
