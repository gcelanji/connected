class SharedPostsController < ApplicationController
  before_action :set_post, only: [:create]
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

  def destroy
  end

  private
  
  def set_post
    @post = Post.find(params[:post_id])
  end
end
