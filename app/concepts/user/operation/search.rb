# frozen_string_literal: true

module User::Operation
  class Search < Trailblazer::Operation
    step :get_users

    def get_users(options, params:, **)
      options['users'] = if options[:is_admin]
                           User.where("name LIKE :name or email LIKE :email", {:name => "%#{params[:search_keyword]}%", :email => "%#{params[:search_keyword]}%"})
                         end
      options['last_search_keyword'] = params[:search_keyword]
    end
  end
end

