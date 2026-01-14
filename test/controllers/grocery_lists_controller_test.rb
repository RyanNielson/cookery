require "test_helper"

class GroceryListsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = users(:one)
    @grocery_list = grocery_lists(:one)
    sign_in_as @user
  end

  test "should get index" do
    get grocery_lists_url
    assert_response :success
  end

  test "should get new" do
    get new_grocery_list_url
    assert_response :success
  end

  test "should create grocery list with recipes and extras" do
    assert_difference("GroceryList.count") do
      assert_difference("GroceryListItem.count", 3) do
        post grocery_lists_url, params: {
          grocery_list: { name: "Weekend run" },
          recipe_ids: [recipes(:one).id, recipes(:three).id],
          extra_items: "Paper towels"
        }
      end
    end

    grocery_list = GroceryList.last
    assert_equal [recipes(:one).id, recipes(:three).id].sort, grocery_list.selected_recipe_ids.sort

    onion_item = grocery_list.grocery_list_items.find_by(name: "Red Onion")
    assert onion_item
    assert_includes onion_item.quantity_text, "1 whole"
    assert_includes onion_item.quantity_text, "1/2 whole"
    assert_redirected_to grocery_list_url(grocery_list)
  end

  test "should show grocery list" do
    get grocery_list_url(@grocery_list)
    assert_response :success
  end

  test "should destroy grocery list" do
    assert_difference("GroceryList.count", -1) do
      delete grocery_list_url(@grocery_list)
    end

    assert_redirected_to grocery_lists_url
  end
end
