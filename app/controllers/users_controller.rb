class UsersController < ApplicationController
    def index
        @users = User.all
    end

    def show
        @user = User.find(params[:id])
    end

    def new
      @user = User.new
    end
  
    def confirm_create
      @user = User.new(user_params)
      unless @user.valid?
          render :new
      end
    end
  
    def create
      @user = User.new(user_params)
      @user.create_user_id = 1
      @user.updated_user_id = 1
  
      if @user.save
        redirect_to @user
      else
        render :new
      end
    end

    def edit
      @user = User.find(params[:id])
    end
  
    def confirm_update
      @user = User.new(user_update_params)
      unless @user.valid?
          render :edit
      end
    end
  
    def update
      @user = User.find(params[:id])
  
      if @user.update(user_update_params)
        redirect_to @user
      else
        render :edit
      end
    end
  
    def destroy
      @user = User.find(params[:id])
      @user.destroy
  
      redirect_to users_path
    end
    

    private
    def user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation, :role, :phone, :dob, :address, :profile, :create_user_id, :updated_user_id)
    end
    def user_update_params
      params.require(:user).permit(:name, :email, :role, :phone, :dob, :address, :profile, :updated_user_id)
    end
end
