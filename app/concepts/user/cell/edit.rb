module User::Cell
  class Edit < Trailblazer::Cell
    include ActionView::Helpers::FormHelper
    include ActionView::Helpers::FormOptionsHelper
    include ActionView::Helpers::DateHelper
    def admin?
      options[:is_admin]
    end
    def image
      if model.profile.present?
        image_tag url_for(model.profile)
      end
    end
  end
end
