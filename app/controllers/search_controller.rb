class SearchController < ApplicationController
  def index
    @query = User.ransack(params[:q])
    @search_results = @query.result(distinct: true)
  end
end
