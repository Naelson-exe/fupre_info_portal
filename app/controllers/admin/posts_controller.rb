class Admin::PostsController < Admin::ApplicationController
  before_action :set_post, only: [ :show, :edit, :update, :destroy ]

  def index
    @posts = Post.all

    # Status filtering
    if params[:status].present? && Post.statuses.key?(params[:status])
      @posts = @posts.where(status: params[:status])
    end

    # Search functionality
    if params[:search].present?
      search_term = "%#{params[:search]}%"
      @posts = @posts.where("title LIKE ? OR content LIKE ? OR summary LIKE ?",
                           search_term, search_term, search_term)
    end

    # Sorting
    if params[:sort].present? && Post.column_names.include?(params[:sort])
      direction = params[:direction] == "desc" ? :desc : :asc
      @posts = @posts.order(params[:sort] => direction)
    else
      @posts = @posts.order(created_at: :desc)
    end
  end

  def show
    # Post is set by before_action
  end

  def new
    @post = current_admin_user.posts.build
  end

  def edit
    # Post is set by before_action
  end

  def create
    @post = current_admin_user.posts.build(post_params)

    if @post.save
      redirect_to admin_post_path(@post), notice: "Post was successfully created."
    else
      flash.now[:alert] = "Please fix the errors below."
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @post.update(post_params)
      respond_to do |format|
        format.html { redirect_to admin_post_path(@post), notice: "Memo was successfully updated." }
        format.json { render json: { status: "success" } }
      end
    else
      respond_to do |format|
        format.html { render :edit }
        format.json { render json: { status: "error", errors: @post.errors.full_messages }, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @post.destroy
    redirect_to admin_posts_url, notice: "Post was successfully deleted."
  rescue => e
    redirect_to admin_posts_url, alert: "Unable to delete post. Please try again."
  end

  def search
    # AJAX search endpoint
    @posts = Post.all

    if params[:q].present?
      search_term = "%#{params[:q]}%"
      @posts = @posts.where("title LIKE ? OR content LIKE ?", search_term, search_term)
    end

    @posts = @posts.limit(10)
    render json: @posts.map { |post| { id: post.id, title: post.title, status: post.status } }
  end

  private

  def set_post
    @post = Post.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    redirect_to admin_posts_path, alert: "Post not found."
  end

  def post_params
    params.require(:post).permit(:title, :summary, :content, :status, :featured, :post_type, :severity)
  end
end
