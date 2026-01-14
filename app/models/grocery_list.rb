class GroceryList < ApplicationRecord
  belongs_to :user
  has_many :grocery_list_items, dependent: :destroy

  serialize :selected_recipe_ids, coder: JSON
  attribute :selected_recipe_ids, default: []

  validates :name, presence: true
end
