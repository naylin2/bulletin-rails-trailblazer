module User::Cell
  class Show < Trailblazer::Cell
    def image
      image_tag url_for(model.profile)
    end
  end
end
