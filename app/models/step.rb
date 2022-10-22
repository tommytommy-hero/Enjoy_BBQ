class Step < ApplicationRecord
  belongs_to :recipe
  validates :explanation, length: { maximum: 100 }, presence: true
end
