require "test_helper"

class MealPlanTest < ActiveSupport::TestCase
  test "requires a start date" do
    meal_plan = meal_plans(:one)
    meal_plan.starts_on = nil

    assert_not meal_plan.valid?
    assert_includes meal_plan.errors[:starts_on], "can't be blank"
  end

  test "enforces unique weeks per user" do
    existing = meal_plans(:one)
    duplicate = MealPlan.new(user: existing.user, starts_on: existing.starts_on)

    assert_not duplicate.valid?
    assert_includes duplicate.errors[:starts_on], "has already been taken"
  end
end
