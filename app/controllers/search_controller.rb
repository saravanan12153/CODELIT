class SearchController < ApplicationController
  def index
    @co = Course.ransack(params[:q])
    @re = Recipe.ransack(params[:q])
    @ca = Cast.ransack(params[:q])
    @courses = @co.result(distinct: true)
    @recipes = @re.result(distinct: true)
    @casts = @ca.result(distinct: true)
    #raise
  end
end
