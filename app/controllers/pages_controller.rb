class PagesController < ApplicationController
  def feed
    @posts = Post.order('created_at DESC')
  end
end
