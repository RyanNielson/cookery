require "test_helper"

class GroceryListItemsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @grocery_list_item = grocery_list_items(:one)
    sign_in_as users(:one)
  end

  test "should update grocery list item" do
    patch grocery_list_grocery_list_item_url(@grocery_list_item.grocery_list, @grocery_list_item), params: {
      grocery_list_item: { purchased: true }
    }

    assert_redirected_to grocery_list_url(@grocery_list_item.grocery_list)
    assert @grocery_list_item.reload.purchased
  end

  test "should create grocery list item" do
    grocery_list = grocery_lists(:one)

    assert_difference("GroceryListItem.count") do
      post grocery_list_grocery_list_items_url(grocery_list), params: {
        grocery_list_item: { name: "Milk", quantity_text: "1 gallon" }
      }
    end

    assert_redirected_to grocery_list_url(grocery_list)
    assert_equal "Milk", GroceryListItem.order(:created_at).last.name
  end
end
