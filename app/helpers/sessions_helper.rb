module SessionsHelper
	def current_user?(user)
		current_user == user
	end

  def signed_in_user
    unless logged_in?
      store_location
      flash[:success] = 'Пожалуйста, зарегистрируйтесь и пользуйтесь сервисом полноценно!'
      redirect_to signin_url
    end
  end

	def redirect_back_or(default)
    redirect_to(session[:return_to] || default)
    session.delete(:return_to)
  end

  def store_location
    session[:return_to] = request.url if request.get?
  end
end
