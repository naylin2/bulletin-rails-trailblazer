# frozen_string_literal: true

module User::Operation
  class Index < Trailblazer::Operation
    step :get_users

    def get_users(options, **)
      options['users'] = if options[:is_admin]
                           User.all
                         end
    end
  end
end

