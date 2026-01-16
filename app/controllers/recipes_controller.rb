class RecipesController < ApplicationController
  before_action :set_recipe, only: %i[ show edit update destroy ]

  def index
    @recipes = Current.user.recipes.order(created_at: :desc)
  end

  def show
  end

  def new
    @recipe = Recipe.new
  end

  def edit
  end

  def create
    @recipe = Current.user.recipes.build(recipe_params)

    if @recipe.save
      redirect_to @recipe, notice: "Recipe was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    purge_image if params.dig(:recipe, :remove_image) == "1"

    if @recipe.update(recipe_params)
      redirect_to @recipe, notice: "Recipe was successfully updated.", status: :see_other
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @recipe.destroy!
    redirect_to recipes_path, notice: "Recipe was successfully destroyed.", status: :see_other
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_recipe
      @recipe = Current.user.recipes.find(params.expect(:id))
    end

    # Only allow a list of trusted parameters through.
    def recipe_params
      params.expect(
        recipe: [
          :name,
          :description,
          :image,
          {
            ingredients_attributes: [ %i[id name quantity unit _destroy] ],
            instructions_attributes: [ %i[id position body _destroy] ]
          }
        ]
      )
    end

    def purge_image
      return unless @recipe.image.attached?

      @recipe.image.purge_later
    end
end
