module User::Operation
  class ResetPassword < Trailblazer::Operation
    class Present < Trailblazer::Operation
      step :model!
      step Contract::Build(constant: User::Contract::ResetPassword)
      
      def model!(options, params:, **)
        options['model'] = User.find_by(email: params['email'])
        if options['model'].present?
          true
        else
          options['fail'] = 'fail'
          false
        end
      end

    end
    step Nested(Present)
    step Contract::Validate()
    step :send_mail

    def send_mail(options, params:, **)
        PasswordMailer.with(user: options['model']).reset.deliver_now
    end
  end
end
