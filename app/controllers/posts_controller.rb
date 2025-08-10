class PostsController < ApplicationController
  before_action :set_post, only: [ :show ]

  def index
    @posts = Post.published

    if params[:search].present?
      search_term = "%#{params[:search]}%"
      @posts = @posts.where("title LIKE ? OR content LIKE ? OR summary LIKE ?",
                           search_term, search_term, search_term)
    end

    @pagy, @posts = pagy(@posts.order(published_at: :desc, created_at: :desc), items: params[:per] || 10)

    respond_to do |format|
      format.html
      format.json do
        render partial: "posts/post_list", formats: [ :html ], locals: { posts: @posts }
      end
    end
  end

  def show
    # Post is set by before_action
  end

  private

  def set_post
    @post = Post.published.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    redirect_to posts_path, alert: "Memo not found"
  end
end
