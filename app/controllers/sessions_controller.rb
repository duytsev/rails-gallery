class SessionsController < ApplicationController

  def new
  end

  def create
    if login(params[:session][:email], params[:session][:password])
      flash[:success] = "Hello, #{@current_user.login}!"
      redirect_back_or_to root_path
    else
      flash.now[:warning] = 'E-mail and/or password is incorrect.'
      render 'new'
    end

  end

  def destroy
    logout
    redirect_to root_path
  end
end
