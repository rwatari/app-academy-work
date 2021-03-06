class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  helper_method :current_user, :logged_in?, :log_in!, :is_admin?


  def log_in!(user)
    @current_user = user
    session[:session_token] = current_user.session_token
  end

  def log_out!
    current_user.reset_session_token!
    session[:session_token] = nil
  end

  def current_user
    @current_user ||=
      User.find_by_session_token(session[:session_token])
  end

  def require_current_user!
    redirect_to new_session_url if current_user.nil?
  end

  def require_logged_out!
    if current_user
      redirect_to user_url(current_user)
    end
  end

  def logged_in?
    !current_user.nil?
  end

  def require_admin!
    unless is_admin?
      render text: "Action for admins only",
             status: :forbidden,
             content_type: "text/html"
    end
  end

  def is_admin?
    return false if current_user.nil?
    current_user.admin
  end

  private

  def user_params
    params.require(:user).permit(:email, :password)
  end
end
