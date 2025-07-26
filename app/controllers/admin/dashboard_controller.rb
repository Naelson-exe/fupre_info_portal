class Admin::DashboardController < Admin::ApplicationController
  def index
    @total_published_posts = Post.published.count
    @total_upcoming_events = Event.where("event_date >= ?", Date.current).count
    @recent_posts = Post.order(created_at: :desc).limit(5)
    @recent_events = Event.order(event_date: :asc).limit(5)
  rescue => e
    Rails.logger.error "Dashboard error: #{e.message}"
    flash.now[:alert] = "Some dashboard data could not be loaded"
    @recent_posts = []
    @recent_events = []
  end
end
