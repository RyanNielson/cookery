class MealPlan < ApplicationRecord
  belongs_to :user
  has_many :meal_plan_entries, dependent: :destroy

  validates :starts_on, presence: true, uniqueness: { scope: :user_id }
end
