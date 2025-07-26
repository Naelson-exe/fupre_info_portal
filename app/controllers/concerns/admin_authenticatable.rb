module AdminAuthenticatable
  extend ActiveSupport::Concern

  included do
    helper_method :current_admin_user, :admin_user_signed_in?
    before_action :authenticate_admin_user!
  end

  def authenticate_admin_user!
    return if admin_user_signed_in?

    flash.now[:alert] = "You must be logged in to access this page."
    redirect_to admin_login_path, alert: "You need to sign in or sign up before continuing."
  end

  def current_admin_user
    @current_admin_user ||= AdminUser.find_by(id: session[:admin_user_id].to_i) if session[:admin_user_id]
  end

  def admin_user_signed_in?
    current_admin_user.present?
  end
end
