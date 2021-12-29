module User::Operation
  class ResetPassword < Trailblazer::Operation
    class Present < Trailblazer::Operation
      step :model!
      step Contract::Build(constant: User::Contract::UpdatePassword)

      def model!(options, params:, **)
        options['model'] = User.find(params['email'])
      end

    end
    step Nested(Present)
    step Contract::Validate(key: :user)
    step send_mail!

    def send_mail!
      if options['model']
        PasswordMailer.with(user: options['model']).reset.deliver_now
        true
      else
        options['fail'] = 'fail'
        false
      end
    end
  end
end