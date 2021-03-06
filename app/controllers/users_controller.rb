class UsersController < ApplicationController

  def new
    @user = User.new
  end
  
  def create
    @user = User.new(user_params)

    if @user.authenticate(params[:user][:password]) && @user.save 
      session[:user_id] = @user.id
      redirect_to root_path
    else
      redirect_to new_user_path
    end

  end

    private
  
    def user_params
      params.require(:user).permit(:user_name, :email, :password)
    end
end
