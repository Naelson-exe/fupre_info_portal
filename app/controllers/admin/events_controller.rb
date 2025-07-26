class Admin::EventsController < Admin::ApplicationController
  before_action :set_event, only: [ :show, :edit, :update, :destroy ]

  def index
    @events = Event.includes(:admin_user)

    # Filter by upcoming/past
    case params[:filter]
    when "upcoming"
      @events = @events.where("event_date >= ?", Date.current)
    when "past"
      @events = @events.where("event_date < ?", Date.current)
    end

    # Search functionality
    if params[:search].present?
      search_term = "%#{params[:search]}%"
      @events = @events.where("title LIKE ? OR details LIKE ?",
                           search_term, search_term)
    end

    # Sorting
    if params[:sort].present? && Event.column_names.include?(params[:sort])
      direction = params[:direction] == "desc" ? :desc : :asc
      @events = @events.order(params[:sort] => direction)
    else
      @events = @events.order(:event_date, :event_time)
    end
  end

  def show
    # Event is set by before_action
  end

  def new
    @event = current_admin_user.events.build
  end

  def edit
    # Event is set by before_action
  end

  def create
    @event = current_admin_user.events.build(event_params)

    if @event.save
      redirect_to admin_event_path(@event), notice: "Event was successfully created."
    else
      flash.now[:alert] = "Please fix the errors below."
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @event.update(event_params)
      respond_to do |format|
        format.html { redirect_to admin_event_path(@event), notice: "Event was successfully updated." }
        format.json { render json: { status: "success" } }
      end
    else
      respond_to do |format|
        format.html { render :edit }
        format.json { render json: { status: "error", errors: @event.errors.full_messages }, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @event.destroy
    redirect_to admin_events_url, notice: "Event was successfully deleted."
  rescue => e
    redirect_to admin_events_url, alert: "Unable to delete event. Please try again."
  end

  def search
    # AJAX search endpoint
    @events = Event.includes(:admin_user)

    if params[:q].present?
      search_term = "%#{params[:q]}%"
      @events = @events.where("title LIKE ? OR details LIKE ?", search_term, search_term)
    end

    @events = @events.limit(10)
    render json: @events.map { |event| {
      id: event.id,
      title: event.title,
      event_date: event.event_date,
      event_time: event.event_time&.strftime("%H:%M")
    } }
  end

  private

  def set_event
    @event = Event.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    redirect_to admin_events_path, alert: "Event not found."
  end

  def event_params
    params.require(:event).permit(:title, :details, :event_date, :event_time, :featured)
  end
end
