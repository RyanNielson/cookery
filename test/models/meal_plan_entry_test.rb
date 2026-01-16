require "test_helper"

class MealPlanEntryTest < ActiveSupport::TestCase
  test "requires a planned date" do
    entry = meal_plan_entries(:one)
    entry.planned_on = nil

    assert_not entry.valid?
    assert_includes entry.errors[:planned_on], "can't be blank"
  end

  test "requires planned date within the meal plan week" do
    entry = meal_plan_entries(:one)
    entry.planned_on = entry.meal_plan.starts_on + 10.days

    assert_not entry.valid?
    assert_includes entry.errors[:planned_on], "must be within the selected week"
  end

  test "requires recipe owned by the same user" do
    entry = meal_plan_entries(:one)
    entry.recipe = recipes(:two)

    assert_not entry.valid?
    assert_includes entry.errors[:recipe], "must belong to the same user as the plan"
  end
end
