class LikesController < ApplicationController
  def create
    klass = like_params[:post_type].constantize
    post = klass.find(like_params[:post_id])
    like = current_user.likes.find_by(post: post)

    if like.nil?
      @like = current_user.likes.new(like_params)
      if !@like.save
        flash.now[:notice] = @like.errors.full_messages.to_sentence
        render json: {success: false, action: :create}
      else
        render json: {success: true, action: :create, count: post.likes.count}
      end
    else
      like.destroy
      render json: {success: true, action: :destroy, count: post.likes.count}
    end
  end

  private

  def like_params
    params.require(:like).permit(:post_id, :post_type)
  end
end
