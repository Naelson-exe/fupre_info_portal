class Admin::DashboardController < ApplicationController
  include AdminAuthenticatable
  before_action :authenticate_admin_user!

  def index
    @recent_activities = [] # Add actual activity tracking logic later
  end
end
