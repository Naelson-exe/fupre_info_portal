class CalendarController < ApplicationController
  def index
    @events = Event.all.to_a
    @deadlines = Event.where(event_type: "deadline").to_a

    if params[:filter].present?
      case params[:filter]
      when "events"
        @deadlines = []
      when "deadlines"
        @events = []
      end
    end
  end
end
