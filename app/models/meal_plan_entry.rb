class MealPlanEntry < ApplicationRecord
  belongs_to :meal_plan
  belongs_to :recipe

  validates :planned_on, presence: true
  validate :planned_on_within_week
  validate :recipe_owner_matches_plan

  private
    def planned_on_within_week
      return if planned_on.blank? || meal_plan.blank? || meal_plan.starts_on.blank?

      week_range = meal_plan.starts_on..(meal_plan.starts_on + 6.days)
      errors.add(:planned_on, "must be within the selected week") unless week_range.cover?(planned_on)
    end

    def recipe_owner_matches_plan
      return if meal_plan.blank? || recipe.blank?

      errors.add(:recipe, "must belong to the same user as the plan") if meal_plan.user_id != recipe.user_id
    end
end
