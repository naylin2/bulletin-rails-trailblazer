# frozen_string_literal: true

class PasswordsController < ApplicationController
  skip_before_action :authorized, only: %i[new create edit editReset updateReset]
  skip_before_action :AdminAuthorized, except: []

  def edit
    run User::Operation::UpdatePassword::Present
      render cell(Password::Cell::Edit, @form)
  end

  def update
    if current_user.authenticate(password_params[:old_password])
      run User::Operation::UpdatePassword, user_id: current_user.id do |result|
        return redirect_to root_path, notice: 'Your password has been changed.'
      end
      if result.failure?
        redirect_to edit_password_path, notice: "Something went wrong."
      end
    else
      redirect_to edit_password_path, notice: "Old password is wrong"
    end
  end

  def new
    render cell(Password::Cell::New, @form)
  end

  def create
    run User::Operation::ResetPassword do |result|
      return redirect_to root_path, notice: 'We have sent a link to reset a password.'
    end
    if result.failure?
      if result['fail']
        redirect_to reset_password_path, notice: 'No account with this email exists.'
      else
        redirect_to reset_password_path, notice: 'Something went wrong.'
      end
    end

    # @user = User.find_by(email: params[:email])
    # if @user.present?
    #   PasswordMailer.with(user: @user).reset.deliver_now
    #   redirect_to root_path, notice: 'We have sent a link to reset a password.'
    # else
    #   redirect_to reset_password_path, notice: 'No account with this email exists.'
    # end
  end

  def editReset
    @user = User.find_signed!(params[:token], purpose: 'password_reset')
  rescue ActiveSupport::MessageVerifier::InvalidSignature
    redirect_to root_path, notice: 'Your token has expired.'
  end

  def updateReset
    @user = User.find_signed(params[:token], purpose: 'password_reset')
    if @user.update(reset_password_params)
      redirect_to root_path, notice: 'Your password has been changed.'
    else
      render editReset
    end
  end

  def password_params
    params.require(:user).permit(:old_password, :password, :password_confirmation)
  end

  def reset_password_params
    params.require(:user).permit(:password, :password_confirmation)
  end
end
