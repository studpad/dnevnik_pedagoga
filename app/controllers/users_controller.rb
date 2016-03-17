class UsersController < ApplicationController
  def index
    @users = User.all
  end

	def new
		@user = User.new
	end

	def create
    @user = User.new user_params
    if @user.save
      auto_login @user
      redirect_to root_path
    else
      @button_name = 'Создать'
      render 'new'
    end
  end

  private
    def user_params
      params.require(:user).permit(:email, :name, :password, :password_confirmation)
    end
end
