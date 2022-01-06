# frozen_string_literal: true

module Post::Cell
  class Index < Trailblazer::Cell
    def last_search_keyword
      last_search_keyword = options[:last_search_keyword]
    end
  end
end

