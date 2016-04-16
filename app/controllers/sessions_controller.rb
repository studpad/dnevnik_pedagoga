class SessionsController < ApplicationController
  skip_before_filter :require_login, except: [:destroy]
  def new
    build_sign_in
  end

  def create
    build_sign_in
    if @session.save and login_from_params
      redirect_back_or_to root_path
    else
      @session.set_error
      flash[:danger] = "Неверный логин и/или пароль."
      redirect_to signin_path
    end
  end

  def destroy
    logout
    flash[:success] = "Успешно вышли"
    redirect_to root_path
  end

  private
    def build_sign_in
      @session = User::SignIn.new(sign_in_params)
    end

    def sign_in_params
      sign_in_params = params[:user_sign_in]
      sign_in_params.permit(:email, :password) if sign_in_params
    end

    def login_from_params
      sign_in_params = params[:user_sign_in]
      login(sign_in_params[:email], sign_in_params[:password]) if sign_in_params
    end

end
