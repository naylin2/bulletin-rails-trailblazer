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
    run User::Operation::Create::Present
      render cell(User::Cell::New, @form, is_admin: admin?)
  end

  def create
    run User::Operation::Create, current_user: current_user do |result|
     return redirect_to users_path, notice: 'Account Created!'
    end
    render cell(User::Cell::New, @form, is_admin: admin?), notice: 'Something went wrong!'
  end

  def edit
    run User::Operation::Update::Present
      render cell(User::Cell::Edit, @form, is_admin: admin?)
  end

  def update
    run User::Operation::Update, current_user: current_user do |result|
      return redirect_to user_path(result[:model]), notice: 'Account Updated!'
    end
    render cell(User::Cell::Edit, @form, is_admin: admin?), notice: 'Something went wrong!'
  end

  def destroy
    run User::Operation::Destroy do |_|
      redirect_to users_path, notice: 'Account deleted!'
    end
  end
end
