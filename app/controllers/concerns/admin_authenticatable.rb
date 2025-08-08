module AdminAuthenticatable
  extend ActiveSupport::Concern

  included do
    helper_method :current_admin_user, :admin_user_signed_in?
    before_action :authenticate_admin_user!
    before_action :check_session_timeout
  end

  def check_session_timeout
    if current_admin_user && session[:last_seen_at] < 30.minutes.ago
      session[:admin_user_id] = nil
      redirect_to admin_login_path, alert: "Your session has expired. Please log in again."
    end
    session[:last_seen_at] = Time.current
  end

  def authenticate_admin_user!
    return if admin_user_signed_in?

    redirect_to admin_login_path, alert: "You need to sign in or sign up before continuing."
  end

  def current_admin_user
    @current_admin_user ||= AdminUser.find_by(id: session[:admin_user_id].to_i) if session[:admin_user_id]
  end

  def admin_user_signed_in?
    current_admin_user.present?
  end
end
