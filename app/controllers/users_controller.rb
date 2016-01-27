class UsersController < ApplicationController

  def index
    @users = User.paginate(page: params[:page]).order('id ASC')
  end

  def show
    @user = User.find(params[:id])
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    @user.admin = true if !has_users
    if @user.save
      session[:has_users] = true
      auto_login @user if !logged_in?
      redirect_to root_path
    else
      render 'new'
    end
  end

  def destroy
    User.find(params[:id]).destroy
    redirect_to users_path
  end

  def reset_password
    user = User.find(params[:id])
    user.update_password
    redirect_to :back
  end

  private

  def user_params
    params.require(:user).permit(:email, :login, :password, :password_confirmation)
  end

end
