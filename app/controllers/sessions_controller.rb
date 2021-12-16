class SessionsController < ApplicationController

  skip_before_action :authorized, only: [:new, :create, :welcome]
  skip_before_action :AdminAuthorized, except: [:page_requires_login]

  def new
  end

  def create
    @user = User.find_by(email: params[:email])
    if @user && @user.authenticate(params[:password])
       session[:user_id] = @user.id
       redirect_to '/welcome'
    else
       redirect_to '/login'
    end
  end

  def login
  end

  def welcome
  end

  def page_requires_login
  end

  def log_out
    session.delete(:user_id)
    redirect_to '/welcome'
  end
end
