class SearchController < ApplicationController
  include Pagy::Backend

  def index
    @query = params[:query]
    if @query.present?
      posts = Post.published.search(@query)
      events = Event.upcoming.search(@query)
      results = (posts + events).sort_by(&:created_at).reverse
      @pagy, @results = pagy_array(results, items: 10)
    else
      @results = []
    end
  end
end
