class Surfboard < ApplicationRecord
  belongs_to :user
  has_many :bookings
  # validate tail to have set of options
  # validate category to have set of options
end
