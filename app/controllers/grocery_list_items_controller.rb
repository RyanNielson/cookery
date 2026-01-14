class GroceryListItemsController < ApplicationController
  before_action :set_grocery_list
  before_action :set_grocery_list_item, only: %i[ update ]

  # POST /grocery_lists/:grocery_list_id/grocery_list_items
  def create
    @grocery_list_item = @grocery_list.grocery_list_items.new(grocery_list_item_params)

    if @grocery_list_item.save
      redirect_to @grocery_list, status: :see_other
    else
      redirect_to @grocery_list, alert: "Could not add grocery list item."
    end
  end

  # PATCH/PUT /grocery_lists/:grocery_list_id/grocery_list_items/1
  def update
    if @grocery_list_item.update(grocery_list_item_params)
      redirect_to @grocery_list, status: :see_other
    else
      redirect_to @grocery_list, alert: "Could not update grocery list item."
    end
  end

  private
    def set_grocery_list
      @grocery_list = Current.user.grocery_lists.find(params.expect(:grocery_list_id))
    end

    def set_grocery_list_item
      @grocery_list_item = @grocery_list.grocery_list_items.find(params.expect(:id))
    end

    def grocery_list_item_params
      params.expect(grocery_list_item: [ :name, :quantity_text, :purchased ])
    end
end
