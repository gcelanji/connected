class CommentsController < ApplicationController
  before_action :set_comment, :set_post, only: :destroy

  def create
    @comment = current_user.comments.new(comment_params)
    if @comment.save
      respond_to do |format|
        format.html { redirect_to post_path(params[:post_id]) }
        format.turbo_stream
      end
    else
      flash.now[:notice] = @comment.errors.full_messages.to_sentence
    end
  end

  def destroy
    @comment.destroy
    respond_to do |format|
      format.html { redirect_to post_path(@post) }
      format.turbo_stream
    end
  end

  private

  def set_comment
    @comment = current_user.comments.find(params[:id])
  end

  def set_post
    @post = Post.find(params[:post_id])
  end

  def comment_params
    params
      .require(:comment)
      .permit(:content)
      .merge(post_id: params[:post_id], post_type: params[:post_type])
  end
end
