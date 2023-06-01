class PostsController < ApplicationController
  before_action :set_post, only: %i[ show edit update destroy ]
  before_action :require_same_user, only: [:edit, :update, :destroy]
  before_action :visibility_check, only: [:show]

  def index
    @posts = current_user.posts
    @shared_posts = current_user.shared_posts
    @all_posts = (@posts + @shared_posts).sort_by(&:created_at).reverse
  end

  def show
  end

  def new
    @post = Post.new
  end

  def create
    # @post = Post.new(post_params)
    @post = current_user.posts.build(post_params)

    respond_to do |format|
      if @post.save
        format.html { redirect_to feed_path, notice: "Post was created successfully." }
        format.json { render :index, status: :created }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  def edit
  end

  def update
    respond_to do |format|
      if @post.update(post_params)
        format.html { redirect_to posts_path, notice: "Post was successfully updated." }
        format.json { render :index, status: :ok }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @post.destroy
    respond_to do |format|
      format.html { redirect_to feed_path, notice: "Post was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_post
    @post = Post.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def post_params
    params.require(:post).permit(:content, :visibility, :user_id)
  end

  def require_same_user
    if current_user != @post.user
      flash[:alert] = "Unauthorized access. You can edit or delete your own posts only."
      redirect_to @post
    end
  end

  def visibility_check
    if (@post.onlyme? && current_user != @post.user) || ((!current_user.is_a_connection_with(@post.user) && current_user != @post.user) && @post.connections?)
      flash[:alert] = "Unauthorized access"
      redirect_back fallback_location: feed_path
    end
  end
end
