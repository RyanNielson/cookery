require "test_helper"

class MealPlansControllerTest < ActionDispatch::IntegrationTest
  setup do
    sign_in_as users(:one)
  end

  test "should get show" do
    get meal_plan_url
    assert_response :success
  end
end
