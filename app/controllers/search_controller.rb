class SearchController < ApplicationController
  def index
    @q = Course.ransack(params[:q])
    @courses = @q.result(distinct: true)
  end
end
