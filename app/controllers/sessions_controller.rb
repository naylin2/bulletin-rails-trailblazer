# frozen_string_literal: true

class SessionsController < ApplicationController
  skip_before_action :authorized, only: %i[new create welcome]
  skip_before_action :AdminAuthorized, except: [:page_requires_login]

  def new; end

  def create
    @user = User.find_by(email: params[:email])
    if @user.present?
      if @user&.authenticate(params[:password])
        cookies.signed[:user_id] = if params[:remember_me]
                                     { value: @user.id, expires: 2.weeks.from_now }
                                   else
                                     @user.id
                                   end
        redirect_to '/welcome', notice: 'You have logged in successfully!'
      else
        redirect_to '/login', notice: 'Password is wrong!'
      end
    else
      redirect_to '/login', notice: "Email doesn't exist!"
    end
  end

  def login; end

  def welcome; end

  def page_requires_login; end

  def log_out
    cookies.delete :user_id
    redirect_to '/welcome'
  end
end
