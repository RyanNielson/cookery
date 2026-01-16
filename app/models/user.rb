class User < ApplicationRecord
  has_many :grocery_lists, dependent: :destroy
  has_secure_password
  has_many :sessions, dependent: :destroy
  has_many :meal_plans, dependent: :destroy
  has_many :meal_plan_entries, through: :meal_plans
  has_many :recipes, dependent: :destroy

  normalizes :email_address, with: ->(e) { e.strip.downcase }
end
