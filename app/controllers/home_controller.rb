class HomeController < ApplicationController
  skip_before_action :authenticate_user!
  before_action :check_signed_in

  def index
  end

  def check_signed_in
    redirect_to feed_path if signed_in?
  end
end
