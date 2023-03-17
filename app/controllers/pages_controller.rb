class PagesController < ApplicationController
  def feed
    @posts = Post.all
    @shared_posts = SharedPost.all
    @all_posts = (@posts + @shared_posts).sort_by(&:created_at).reverse
  end
end
