# frozen_string_literal: true

class SessionsController < ApplicationController
  skip_before_action :authorized, only: %i[new create welcome]
  skip_before_action :AdminAuthorized, except: [:page_requires_login]

  def new
    run User::Operation::Login::Present
      render cell(User::Cell::Login, @form)
  end

  def create
    run User::Operation::Login do |result|
      if result[:remember_me]
        cookies.signed[:user_id] = { value: result[:user][:id], expires: 2.weeks.from_now }
      else
        cookies.signed[:user_id] = result[:user][:id]
      end
      redirect_to '/welcome', notice: 'You have logged in successfully!'
      return
    end
    if result.failure?
      if result[:email_pwd_fail]
        redirect_to login_path, notice: "Invalid Password!"
        return
      end
      if result[:user_fail]
        redirect_to login_path, notice: "Email does not exist!"
      else
        redirect_to login_path, notice: "Something went wrong!"
        return
      end
    end
  end

  def welcome; end

  def log_out
    cookies.delete :user_id
    redirect_to '/welcome'
  end
end
