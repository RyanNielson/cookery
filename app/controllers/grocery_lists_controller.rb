class GroceryListsController < ApplicationController
  before_action :set_grocery_list, only: %i[ show destroy ]

  # GET /grocery_lists
  def index
    @grocery_lists = Current.user.grocery_lists.includes(:grocery_list_items).order(created_at: :desc)
  end

  # GET /grocery_lists/1
  def show
    @selected_recipes = Current.user.recipes.where(id: @grocery_list.selected_recipe_ids)
    @grocery_list_items = @grocery_list.grocery_list_items.order(:name)
  end

  # GET /grocery_lists/new
  def new
    load_recipes
    @grocery_list = Current.user.grocery_lists.new
    @selected_recipe_ids = []
    @extra_items_text = ""
  end

  # POST /grocery_lists
  def create
    load_recipes
    @selected_recipe_ids = Array(params[:recipe_ids]).reject(&:blank?)
    @extra_items_text = params[:extra_items].to_s
    extra_items = parse_extra_items(@extra_items_text)
    selected_recipes = @recipes.where(id: @selected_recipe_ids)
    @selected_recipe_ids = selected_recipes.pluck(:id)

    @grocery_list = Current.user.grocery_lists.new(
      name: grocery_list_params[:name],
      selected_recipe_ids: @selected_recipe_ids
    )

    if @grocery_list.save
      create_items_from_recipes(selected_recipes)
      create_extra_items(extra_items)
      redirect_to @grocery_list, notice: "Grocery list was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  # DELETE /grocery_lists/1
  def destroy
    @grocery_list.destroy!
    redirect_to grocery_lists_path, notice: "Grocery list was successfully destroyed.", status: :see_other
  end

  private
    def set_grocery_list
      @grocery_list = Current.user.grocery_lists.find(params.expect(:id))
    end

    def load_recipes
      @recipes = Current.user.recipes.order(:name)
    end

    def grocery_list_params
      params.expect(grocery_list: [ :name ])
    end

    def parse_extra_items(raw_text)
      raw_text.to_s.lines.map(&:strip).reject(&:blank?)
    end

    def create_items_from_recipes(recipes)
      recipes
        .includes(:ingredients)
        .flat_map(&:ingredients)
        .group_by(&:name)
        .each do |name, ingredients|
          quantities = ingredients.map { |ingredient| format_quantity(ingredient) }
          @grocery_list.grocery_list_items.create!(
            name: name,
            quantity_text: quantities.join(" · ")
          )
        end
    end

    def create_extra_items(extra_items)
      extra_items.each do |item|
        @grocery_list.grocery_list_items.create!(name: item)
      end
    end

    def format_quantity(ingredient)
      [ingredient.quantity, ingredient.unit].compact_blank.join(" ").presence || "Amount not specified"
    end
end
