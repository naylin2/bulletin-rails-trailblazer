class PasswordsController < ApplicationController
    skip_before_action :authorized, only: []
    skip_before_action :AdminAuthorized, except: []

    def edit
    
    end

    def update
        if current_user.authenticate(password_params[:old_password])
            if current_user.update(password_params)
                redirect_to root_path
            else
            render :edit
            end
        else
            render :edit
        end
    end
    
    def password_params
        params.permit(:old_password, :password, :password_confirmation)
      end
end
