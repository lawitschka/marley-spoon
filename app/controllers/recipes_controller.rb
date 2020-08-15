class RecipesController < ApplicationController
  def index
    @recipes = FetchRecipes.all
  end

  def show
    @recipe = FetchRecipes.single(params[:id])
  rescue FetchRecipes::MissingRecipeError
    render file: 'public/404.html', status: :not_found, layout: false
  end
end
