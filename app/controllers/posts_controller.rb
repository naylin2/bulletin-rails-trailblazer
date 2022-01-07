# frozen_string_literal: true

class PostsController < ApplicationController
  skip_before_action :authorized, only: %i[index show]
  skip_before_action :AdminAuthorized, except: []

  # show post list
  def index
    run Post::Operation::Index, current_user: current_user, is_admin: admin? do |result|
      render cell(Post::Cell::Index, result[:posts])
    end
  end

  # function: show
  # show post detail page
  def show
    run Post::Operation::Update::Present do |result|
      render cell(Post::Cell::Show, result[:model])
    end
    check_resource(result[:model])
  end

  # function: new
  # show post create form
  def new
    run Post::Operation::Create::Present
      render cell(Post::Cell::New, @form)
  end

  # function: create
  # create post
  # params: current_user
  def create
    run Post::Operation::Create, current_user: current_user do |result|
     return redirect_to posts_path, notice: 'Post Created!'
    end
    render cell(Post::Cell::New, @form)
  end

  # function: edit
  # show post edit form
  def edit
    run Post::Operation::Update::Present do |result|
      render cell(Post::Cell::Edit, @form)
    end
    check_resource(result[:model])
  end

  # function: update
  # update post
  # params: current_user
  def update
    run Post::Operation::Update, current_user: current_user do |result|
      return redirect_to post_path(result[:model]), notice: 'Post Updated'
    end
    render cell(Post::Cell::Edit, @form)
  end

  # function: destroy
  # destroy post
  # params: current_user
  def destroy
    run Post::Operation::Destroy, current_user: current_user do |result|
      redirect_to posts_path, notice: 'Post deleted!'
    end
    check_resource(result[:model])
  end

  # function: export
  # download post list csv
  # @return [<Type>] <csv>
  def download
    run Post::Operation::Export::CsvData do |result|
      respond_to do |format|
        format.html
        format.csv { send_data result[:csv_text],  :filename => "Post List.csv" }
      end
    end
  end

  # function: upload
  # show post import form
  def upload_csv
    run Post::Operation::Import::Present
      render cell(Post::Cell::Import, @form)
  end

  # function: action_import
  # import post csv
  # params: current_user
  def import_csv
    run Post::Operation::Import, current_user_id: current_user.id do |_|
      return redirect_to posts_path, notice: 'Imported Successfully!'
    end
    render cell(Post::Cell::Import, @form)
  end

  # function: search
  # search post by keyword
  # params: current_user
  # @return [<Type>] <post>
  def search
    run Post::Operation::Search, current_user: current_user, is_admin: admin? do |result|
      render cell(Post::Cell::Index, result[:posts], last_search_keyword: result[:last_search_keyword])
    end
  end
end
