class Instruction < ApplicationRecord
  belongs_to :recipe

  validates :body, presence: true
  validates :position, presence: true, numericality: { only_integer: true }
end
