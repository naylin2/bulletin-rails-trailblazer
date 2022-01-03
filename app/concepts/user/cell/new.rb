module User::Cell
  class New < Trailblazer::Cell
    include ActionView::Helpers::FormHelper
    include ActionView::Helpers::FormOptionsHelper
    include ActionView::Helpers::DateHelper
    
    def admin?
      options[:is_admin]
    end
  end
end
