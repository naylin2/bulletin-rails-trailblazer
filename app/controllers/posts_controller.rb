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
    @post.create_user_id = 1
    @post.updated_user_id = 1

    if @post.save
      redirect_to @post
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

    if @post.update(post_update_params)
      redirect_to @post
    else
      render :edit
    end
  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy

    redirect_to root_path
  end

  private
    def post_params
      params.require(:post).permit(:title, :description)
    end

    def post_update_params
      params.require(:post).permit(:title, :description)
    end

end
