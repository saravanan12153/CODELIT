class RecipesController < ApplicationController
  before_action :set_recipe, only: [:show]

  def index
    if params[:tag].present?
      @recipes = Recipe.where(publish: true).tagged_with(params[:tag]).order('created_at ASC').page(params[:page]).per(9)
    else
      @recipes = Recipe.where(publish: true).all.order('created_at ASC').page(params[:page]).per(9)
    end
  end

  def show
    @recipe.update_column('count_views', @recipe.count_views + 1) if @recipe.present?
  end

  def feed
    @recipes = Recipe.where(publish: true).all
    respond_to do |format|
      format.rss { render :layout => false }
    end
  end

  private
  def set_recipe
    @recipe = Recipe.where(publish: true).friendly.find(params[:id])
  end
end
