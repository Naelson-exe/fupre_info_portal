class SearchController < ApplicationController
  def index
    @query = params[:query]
    @search_scope = params[:search_scope]&.to_sym

    if @query.blank? && @search_scope.blank?
      @results = []
    else
      @results = case @search_scope
      when :post
                   Post.published.search(@query)
      when :event
                   events = Event.upcoming.search(@query)
                   events = events.where("event_date >= ?", params[:start_date]) if params[:start_date].present?
                   events = events.where("event_date <= ?", params[:end_date]) if params[:end_date].present?
                   events
      else
                   (Post.published.search(@query) + Event.upcoming.search(@query)).sort_by(&:created_at).reverse
      end
    end

    # Simple pagination
    @results = Kaminari.paginate_array(@results).page(params[:page]).per(10)
  end
end
