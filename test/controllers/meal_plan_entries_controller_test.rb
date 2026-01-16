require "test_helper"

class MealPlanEntriesControllerTest < ActionDispatch::IntegrationTest
  setup do
    sign_in_as users(:one)
    @meal_plan = meal_plans(:one)
    @recipe = recipes(:one)
  end

  test "should create meal plan entry" do
    assert_difference("MealPlanEntry.count") do
      post meal_plan_entries_url, params: {
        meal_plan_id: @meal_plan.id,
        meal_plan_entry: { recipe_id: @recipe.id, planned_on: @meal_plan.starts_on }
      }
    end

    assert_redirected_to meal_plan_url(week: @meal_plan.starts_on)
  end

  test "should destroy meal plan entry" do
    entry = meal_plan_entries(:one)

    assert_difference("MealPlanEntry.count", -1) do
      delete meal_plan_entry_url(entry)
    end

    assert_redirected_to meal_plan_url(week: entry.meal_plan.starts_on)
  end
end
