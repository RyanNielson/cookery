class Recipe < ApplicationRecord
  belongs_to :user
  has_many :ingredients, dependent: :destroy
  has_many :instructions, -> { order(:position) }, dependent: :destroy
  has_many :meal_plan_entries, dependent: :destroy
  has_one_attached :image

  accepts_nested_attributes_for :ingredients, allow_destroy: true, reject_if: :all_blank
  accepts_nested_attributes_for :instructions, allow_destroy: true, reject_if: :all_blank

  validates :name, presence: true
end
