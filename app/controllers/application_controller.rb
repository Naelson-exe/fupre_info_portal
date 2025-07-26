class ApplicationController < ActionController::Base
  include Pagy::Backend
  protect_from_forgery with: :exception

  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found

  private

  def record_not_found
    redirect_to root_path, alert: "The requested page could not be found"
  end
end
