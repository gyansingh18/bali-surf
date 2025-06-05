class Review < ApplicationRecord
  belongs_to :booking

  RATINGS = (1..10).to_a

  validates :rating, presence: true, inclusion: { in: RATINGS }
  validates :comment, presence: true
end
