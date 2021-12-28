module Password::Cell
  class Edit < Trailblazer::Cell
    def user
      options[:user]
    end
  end
end