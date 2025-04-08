class SharedPostsController < ApplicationController
  before_action :set_post, only: [:create]
  before_action :set_shared_post, only: [:show, :destroy]

  def create
    @shared_post = current_user.shared_posts.new(post: @post)
      if @shared_post.save
        flash[:notice] = "Post was shared to your profile"
        redirect_back fallback_location: feed_path
      else
        flash[:alert] = @shared_post.errors.full_messages.to_sentence
        redirect_back fallback_location: feed_path
      end
  end

  def show
  end

  def destroy
    if @shared_post.destroy
      flash[:notice] = "Post was deleted"
      redirect_to feed_path
    end
  end

  private
  
  def set_post
    @post = Post.find(params[:post_id])
  end

  def set_shared_post
    @shared_post = SharedPost.find(params[:id])
  end
end
