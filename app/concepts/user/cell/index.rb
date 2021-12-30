# frozen_string_literal: true

module User::Cell
  class Index < Trailblazer::Cell
    def admin?
      options[:is_admin]
    end
  end
end

