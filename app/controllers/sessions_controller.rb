class SessionsController < ApplicationController


  skip_before_action :authorized, only: [:new, :create, :welcome]
  skip_before_action :AdminAuthorized, except: [:page_requires_login]

  def new
  end

  def create
    @user = User.find_by(email: params[:email])
    if @user.present?
      if @user && @user.authenticate(params[:password])
        if params[:remember_me]
          cookies.signed[:user_id] ={ value: @user.id, expires: 2.weeks.from_now }
        else
          cookies.signed[:user_id] = @user.id
        end
        redirect_to '/welcome', notice: "You have logged in successfully!"
      else
        redirect_to '/login', notice: "Password is wrong!"
      end
    else
      redirect_to '/login', notice: "Email doesn't exist!"
    end
  end

  def login
  end

  def welcome
  end

  def page_requires_login
  end

  def log_out
    cookies.delete :user_id
    redirect_to '/welcome'
  end
end
