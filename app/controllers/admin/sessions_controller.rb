class Admin::SessionsController < Admin::ApplicationController
  skip_before_action :authenticate_admin_user!, only: [ :new, :create ]
  layout "admin", except: [ :new ]

  def new
    render layout: false
  end

  def create
    admin_user = AdminUser.find_by(email: params[:email]&.downcase)
    if admin_user&.authenticate(params[:password])
      session[:admin_user_id] = admin_user.id.to_s
      admin_user.update(last_login_at: Time.current)
      redirect_to admin_root_path, notice: "Logged in successfully"
    else
      flash.now[:error] = "Invalid email or password"
      render :new, layout: false, status: :unprocessable_entity
    end
  end

  def destroy
    session[:admin_user_id] = nil
    redirect_to admin_login_path, notice: "Logged out successfully"
  end
end
