class Booking < ApplicationRecord
  belongs_to :user
  belongs_to :surfboard

  # consider adding validation for start_date and end_date should be in the future
  validates :start_date, presence: true
  validates :end_date, presence: true
  validates :total_price, presence: true
  STATUSES = ["pending", "accepted", "denied"]
  validates :status, presence: true, inclusion: { in: STATUSES }
end
