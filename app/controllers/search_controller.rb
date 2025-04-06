class SearchController < ApplicationController
  def index
    redirect_to feed_path if params[:q].dig(:first_name_or_last_name_or_email_cont).blank?
    @query = User.ransack(params[:q])
    @search_results = @query.result(distinct: true)
  end
end
