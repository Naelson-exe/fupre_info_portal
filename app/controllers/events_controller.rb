class EventsController < ApplicationController
  before_action :set_event, only: [ :show ]

  def index
    @upcoming_events = Event.where("event_date >= ?", Date.current)
                           .order(:event_date, :event_time)

    @past_events = Event.where("event_date < ?", Date.current)
                       .order(event_date: :desc, event_time: :desc)

    if params[:search].present?
      search_term = "%#{params[:search]}%"
      @upcoming_events = @upcoming_events.where("title LIKE ? OR details LIKE ?", search_term, search_term)
      @past_events = @past_events.where("title LIKE ? OR details LIKE ?", search_term, search_term)
    end

    @pagy_upcoming, @upcoming_events = pagy(@upcoming_events, items: params[:per] || 10, page_param: :upcoming_page)
    @pagy_past, @past_events = pagy(@past_events, items: params[:per] || 10, page_param: :past_page)
  end

  def show
    # Event is set by before_action
  end

  private

  def set_event
    @event = Event.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    redirect_to events_path, alert: "Event not found"
  end
end
