class Ingredient < ApplicationRecord
  belongs_to :recipe

  normalizes :name, with: ->(value) { value.to_s.squish.titleize }
  validates :name, presence: true
end
