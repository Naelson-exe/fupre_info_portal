class Admin::SessionsController < ApplicationController
  layout 'admin', except: [:new]

  def new
    render layout: false
  end

  def create
    admin_user = AdminUser.find_by(email: params[:email].downcase)
    if admin_user&.authenticate(params[:password])
      session[:admin_user_id] = admin_user.id.to_s # Store as string
      admin_user.update(last_login_at: Time.current)
      flash[:notice] = "Logged in successfully"
      redirect_to admin_root_path
    else
      flash.now[:alert] = "Invalid email or password"
      render :new, layout: false
    end
  end

  def destroy
    session[:admin_user_id] = nil
    flash[:notice] = "Logged out successfully"
    redirect_to admin_login_path
  end
end
