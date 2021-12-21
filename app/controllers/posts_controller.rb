class PostsController < ApplicationController

  skip_before_action :authorized, only: [:index, :show]
  skip_before_action :AdminAuthorized, except: []

  def index
    @posts = Post.all
  end

  def show
    @post = Post.find(params[:id])
  end

  def new
    @post = Post.new
  end

  def confirm_create
    @post = Post.new(post_params)
    unless @post.valid?
        render :new
    end
  end

  def create
    @post = Post.new(post_params)
    @post.status = 1
    @post.create_user_id = current_user.id
    @post.updated_user_id = current_user.id

    if @post.save
      redirect_to posts_path, notice: "Post Created!"
    else
      render :new
    end
  end

  def edit
    @post = Post.find(params[:id])
  end

  def confirm_update
    @post = Post.new(post_update_params)
    unless @post.valid?
        render :edit
    end
  end

  def update
    @post = Post.find(params[:id])
    @post.updated_user_id = current_user.id

    if @post.update(post_update_params)
      redirect_to @post, notice: "Post Updated!"
    else
      render :edit
    end
  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy

    redirect_to posts_path, notice: "Post deleted!"
  end

  def download
    @posts = Post.all
    respond_to do |format|
        format.html
        format.csv { send_data @posts.to_csv,  :filename => "Post List.csv" }
      end
  end

  def import_csv
      updated_user_id = current_user.id
      create_user_id = current_user.id
      if (params[:file].nil?)
          redirect_to upload_csv_posts_path, notice: "Require File"        
      elsif !File.extname(params[:file]).eql?(".csv")
          redirect_to upload_csv_posts_path, notice: "Wrong File Type"  
      else
          error_msg = PostsHelper.check_header(["title", "description", "status"],params[:file])
          if error_msg.present?
              redirect_to upload_csv_posts_path, notice: error_msg
          else 
              Post.import(params[:file],create_user_id,updated_user_id)
              redirect_to posts_path, notice: "Imported Successfully!"
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

