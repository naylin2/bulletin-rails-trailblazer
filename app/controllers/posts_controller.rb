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
    run Post::Operation::Create::Present do |result|
      render cell(Post::Cell::New, @form)
    end
  end

  def create
    run Post::Operation::Create, current_user: current_user do |result|
      redirect_to posts_path, notice: 'Post Created!'
    end
    render cell(Post::Cell::New, @form)
  end

  def edit
    @post = Post.find(params[:id])
  end

  def update
    @post = Post.find(params[:id])
    @post.updated_user_id = current_user.id

    if @post.update(post_update_params)
      redirect_to @post, notice: 'Post Updated!'
    else
      render :edit
    end
  end

  def destroy
    run Post::Operation::Destroy do |_|
      redirect_to posts_path, notice: 'Post deleted!'
    end
  end

  def download
    @posts = Post.all
    respond_to do |format|
      format.html
      format.csv { send_data @posts.to_csv, filename: 'Post List.csv' }
    end
  end

  def import_csv
    updated_user_id = current_user.id
    create_user_id = current_user.id
    if params[:file].nil?
      redirect_to upload_csv_posts_path, notice: 'Require File'
    elsif !File.extname(params[:file]).eql?('.csv')
      redirect_to upload_csv_posts_path, notice: 'Wrong File Type'
    else
      error_msg = PostsHelper.check_header(%w[title description status], params[:file])
      if error_msg.present?
        redirect_to upload_csv_posts_path, notice: error_msg
      else
        Post.import(params[:file], create_user_id, updated_user_id)
        redirect_to posts_path, notice: 'Imported Successfully!'
      end
    end
  end

  private

  def post_params
    params.require(:post).permit(:title, :description)
  end

  def post_update_params
    params.require(:post).permit(:title, :description, :status)
  end
end
