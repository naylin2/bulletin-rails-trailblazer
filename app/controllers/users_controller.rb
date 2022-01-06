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
    check_resource(result[:model])
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
      render cell(User::Cell::New, @form, is_admin: admin?)
    else
      run User::Operation::Signup do |result|
        return redirect_to welcome_path, notice: 'Account Created!'
      end
      render cell(User::Cell::Signup, @form), notice: 'Something went wrong!'
    end
  end

  def edit
    run User::Operation::Update::Present do |result|
      render cell(User::Cell::Edit, @form, is_admin: admin?)
    end
    check_resource(result[:model])
  end

  def update
    run User::Operation::Update, current_user: current_user do |result|
      return redirect_to user_path(result[:model]), notice: 'Account Updated!'
    end
    render cell(User::Cell::Edit, @form, is_admin: admin?)
  end

  def destroy
    run User::Operation::Destroy, current_user: current_user do |result|
      redirect_to users_path, notice: 'Account deleted!'
    end
    check_resource(result[:model])
  end

  def search
    run User::Operation::Search, is_admin: admin? do |result|
      render cell(User::Cell::Index, result[:users], is_admin: admin?, last_search_keyword: result[:last_search_keyword])
    end
  end
end
