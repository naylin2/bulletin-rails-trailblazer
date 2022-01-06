# frozen_string_literal: true

module User::Cell
  class Index < Trailblazer::Cell
    def admin?
      options[:is_admin]
    end
    def last_search_keyword
      last_search_keyword = options[:last_search_keyword]
    end
  end
end

