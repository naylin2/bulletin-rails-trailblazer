# frozen_string_literal: true

class PostsController < ApplicationController
  skip_before_action :authorized, only: %i[index show]
  skip_before_action :AdminAuthorized, except: []

  def index
    run Post::Operation::Index, current_user: current_user, is_admin: admin? do |result|
      render cell(Post::Cell::Index, result[:posts])
    end
  end

  def show
    run Post::Operation::Update::Present do |result|
      render cell(Post::Cell::Show, result[:model])
    end
  end

  def new
    run Post::Operation::Create::Present
      render cell(Post::Cell::New, @form)
  end

  def create
    run Post::Operation::Create, current_user: current_user do |result|
     return redirect_to posts_path, notice: 'Post Created!'
    end
    render cell(Post::Cell::New, @form)
  end

  def edit
    run Post::Operation::Update::Present
      render cell(Post::Cell::Edit, @form)
  end

  def update
    run Post::Operation::Update, current_user: current_user do |result|
      return redirect_to post_path(result[:model]), notice: 'Post Updated'
    end
    render cell(Post::Cell::Edit, @form)
  end

  def destroy
    run Post::Operation::Destroy do |_|
      redirect_to posts_path, notice: 'Post deleted!'
    end
  end

  def download
    run Post::Operation::Export::CsvData do |result|
      respond_to do |format|
        format.html
        format.csv { send_data result[:csv_text],  :filename => "Post List.csv" }
      end
    end
  end

  def upload_csv
      render cell(Post::Cell::Import, @form)
  end

  def import_csv
    run Post::Operation::Import, current_user_id: current_user.id do |_|
      return redirect_to posts_path, notice: 'Imported Successfully!'
    end
    redirect_to upload_csv_posts_path, notice: 'Something went wrong.'
  end
end
