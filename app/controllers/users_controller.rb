class UsersController < ApplicationController
  include SessionsHelper
  before_action :signed_in_user,
                only: [:index, :edit, :update, :destroy, :following, :followers]
  before_action :correct_user, only: [:edit, :update]

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
      flash[:success] = "Добро пожаловать! Читайте дневники других педагогов, черпайте материал и вдохновение!"
      redirect_to root_path
    else
      render 'new'
    end
  end

  def edit
    @user = current_user
  end

  def update
    @user = current_user
    if @user.update_attributes(user_params)
      flash[:success] = "Профиль успешно изменен."
      redirect_to @user
    else
      flash.now[:danger] = "Ошибка при изменении профиля."
      render 'edit'
    end
  end

  def destroy
    User.find(params[:id]).destroy
    flash[:success] = "Пользователь удален"
    redirect_to users_path
  end

  def show
    @user = User.find(params[:id])
    @articles = @user.articles
  end

  def following
    @title = "Following"
    @user = User.find(params[:id])
    @users = @user.followed_users
    render 'show_follow'
  end

  def followers
    @title = "Followers"
    @user = User.find(params[:id])
    @users = @user.followers
    render 'show_follow'
  end

  private
    def user_params
      params.require(:user).permit(:email, :name, :password, :password_confirmation)
    end

    def correct_user
      @user = User.find(params[:id])
      redirect_to(root_url) unless current_user?(@user)
    end
end
