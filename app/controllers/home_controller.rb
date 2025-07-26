class HomeController < ApplicationController
  def index
    @featured_posts = Post.where(featured: true).published
                         .includes(:admin_user)
                         .order(published_at: :desc, created_at: :desc)
                         .limit(2)
    @featured_events = Event.where(featured: true)
                           .includes(:admin_user)
                           .where("event_date >= ?", Date.current)
                           .order(:event_date, :event_time)
                           .limit(2)

    @latest_posts = Post.published
                       .includes(:admin_user)
                       .order(published_at: :desc, created_at: :desc)
                       .limit(3)

    @upcoming_events = Event.includes(:admin_user)
                           .where("event_date >= ?", Date.current)
                           .order(:event_date, :event_time)
                           .limit(3)
  rescue => e
    Rails.logger.error "Error loading homepage data: #{e.message}"
    @featured_posts = []
    @featured_events = []
    @latest_posts = []
    @upcoming_events = []
    flash.now[:alert] = "Some content could not be loaded"
  end
end
