class ApplicationController < ActionController::Base
  include Pagy::Backend
  include ParameterSanitizer
  protect_from_forgery with: :exception
  before_action :track_page_view

  rescue_from ActiveRecord::RecordNotFound, with: :not_found
  rescue_from ActionController::RoutingError, with: :not_found

  def not_found
    render "errors/not_found", status: :not_found
  end

  private

  def track_page_view
    PageView.create(
      path: request.path,
      user_agent: request.user_agent,
      ip_address: request.remote_ip
    )
  end
end
