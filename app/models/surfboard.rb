class Surfboard < ApplicationRecord
  belongs_to :user
  has_many :bookings
  CATEGORIES = ["Longboard", "Shortboard", "Softboard"]
  # we've removed validates presence: true due to bug, perhaps unnessary with inclusion.
  validates :category, inclusion: { in: CATEGORIES }
  validates :size, presence: true
  TAIL_TYPES = ["Square Tail", "Squash Tail", "Round Tail", "Pin Tail", "Swallow Tail"]
  validates :tail, presence: true, inclusion: { in: TAIL_TYPES }
  validates :location, presence: true
  validates :price, presence: true
end
