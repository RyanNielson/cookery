class GroceryListItem < ApplicationRecord
  belongs_to :grocery_list, touch: true

  attribute :purchased, :boolean, default: false

  validates :name, presence: true
end
