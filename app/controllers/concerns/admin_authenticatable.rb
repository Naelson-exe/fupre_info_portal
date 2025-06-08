module AdminAuthenticatable
  extend ActiveSupport::Concern

  included do
    helper_method :current_admin_user, :admin_user_signed_in?
    before_action :authenticate_admin_user!, except: [:new, :create]
  end

  def authenticate_admin_user!
    redirect_to admin_login_path, alert: "Please log in" unless admin_user_signed_in?
  end

  def current_admin_user
    @current_admin_user ||= AdminUser.find_by(id: session[:admin_user_id].to_i) if session[:admin_user_id]
  end

  def admin_user_signed_in?
    current_admin_user.present?
  end
end
