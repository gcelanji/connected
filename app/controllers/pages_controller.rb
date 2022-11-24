class PagesController < ApplicationController
  def feed
    @posts = Post.all
  end
end
