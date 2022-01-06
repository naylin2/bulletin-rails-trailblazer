# frozen_string_literal: true

module Post::Operation
  class Search < Trailblazer::Operation
    step :get_posts

    def get_posts(options, params:, **)
      options['posts'] = if options[:is_admin]
                          Post.where("title LIKE :title or description LIKE :desc", {:title => "%#{params[:search_keyword]}%", :desc => "%#{params[:search_keyword]}%"})
                         else
                          Post.where(create_user_id: options[:current_user].id).where("title LIKE :title or description LIKE :desc", {:title => "%#{params[:search_keyword]}%", :desc => "%#{params[:search_keyword]}%"})
                         end
      options['last_search_keyword'] = params[:search_keyword]
    end
  end
end
