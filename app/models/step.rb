class Step < ApplicationRecord
  belongs_to :recipe
  validates :explanation, presence: true
end
