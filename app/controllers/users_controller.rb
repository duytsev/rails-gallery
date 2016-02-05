class UsersController < ApplicationController
  before_action :require_login
  before_action :admin_user

  def index
    @users = User.paginate(page: params[:page]).order('id ASC')
  end

  def show
    @user = User.find(params[:id])
  end

  def new
    @user = User.new
    @user.admin = true if !has_users
  end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:has_users] = true
      flash[:success] = "User #{@user.login} successfully created"
      if !logged_in?
        auto_login @user
        flash[:success] = "Hello, #{@user.login}!"
      end
      redirect_to users_path
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
    user.update_password(old_password: params[:old_password],
                         new_password: params[:new_password],
                         new_password_confirmation: params[:new_password_confirmation])
    redirect_to user
  end

  def not_authenticated
    redirect_to login_path
  end

  private

  def user_params
    params.require(:user).permit(:email, :login, :password, :password_confirmation)
  end

  def admin_user
    redirect_to root_path if !current_user.admin
  end

end
