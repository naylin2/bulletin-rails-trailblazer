# frozen_string_literal: true

class UsersController < ApplicationController
  skip_before_action :authorized, only: %i[new create]
  skip_before_action :AdminAuthorized, except: %i[destroy index]

  def index
    run User::Operation::Index, is_admin: admin? do |result|
      render cell(User::Cell::Index, result[:users], is_admin: admin?)
    end
  end

  def show
    run User::Operation::Update::Present do |result|
      render cell(User::Cell::Show, result[:model])
    end
  end

  def new
    if logged_in?
      run User::Operation::Create::Present
        render cell(User::Cell::New, @form, is_admin: admin?)
    else
      run User::Operation::Signup::Present
        render cell(User::Cell::Signup, @form)
    end
  end

  def create
    if logged_in?
      run User::Operation::Create, current_user: current_user do |result|
      return redirect_to users_path, notice: 'Account Created!'
      end
      if result.failure?
        errors = result["contract.default"].errors.to_hash(true).map{|k, v| v.join("。")}
        redirect_to new_user_path(@form), notice: errors.join("。")
      end
      # render cell(User::Cell::New, @form), notice: 'Something went wrong!'
    else
      run User::Operation::Signup do |result|
        return redirect_to welcome_path, notice: 'Account Created!'
      end
      byebug
      render cell(User::Cell::Signup, @form), notice: 'Something went wrong!'
    end
  end

  def edit
    run User::Operation::Update::Present
      render cell(User::Cell::Edit, @form, is_admin: admin?)
  end

  def update
    run User::Operation::Update, current_user: current_user do |result|
      return redirect_to user_path(result[:model]), notice: 'Account Updated!'
    end
    if result.failure?
      errors = result["contract.default"].errors.to_hash(true).map{|k, v| v.join("。")}
      redirect_to edit_user_path(params[:id]), notice: errors.join("。")
    end
  end

  def destroy
    run User::Operation::Destroy do |_|
      redirect_to users_path, notice: 'Account deleted!'
    end
  end
end
