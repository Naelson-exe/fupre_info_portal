class ApplicationController < ActionController::Base
  include Pagy::Backend
  include ParameterSanitizer
  protect_from_forgery with: :exception
  before_action :track_page_view

  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found

  private

  def track_page_view
    PageView.create(
      path: request.path,
      user_agent: request.user_agent,
      ip_address: request.remote_ip
    )
  end

  def record_not_found
    redirect_to root_path, alert: "The requested page could not be found"
  end
end
