class CommentsController < ApplicationController
  before_action :set_comment, :set_post, only: :destroy

  def create
    # create a new comment
    @comment = current_user.comments.new(comment_params)
    if @comment.save
      redirect_to post_path(params[:post_id])
    else
      flash[:notice] = @comment.errors.full_messages.to_sentence
    end
  end

  def destroy
    @comment.destroy
    respond_to do |format|
      format.html { redirect_to post_path(@post) }
      format.json { head :no_content }
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
      .merge(post_id: params[:post_id])
  end
end
