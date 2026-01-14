require "test_helper"

class IngredientTest < ActiveSupport::TestCase
  test "normalizes name before validation" do
    ingredient = recipes(:one).ingredients.create!(name: "  red   onion  ")

    assert_equal "Red Onion", ingredient.name
  end
end
