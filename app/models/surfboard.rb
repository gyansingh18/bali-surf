# app/models/surfboard.rb
class Surfboard < ApplicationRecord
  # Associations
  belongs_to :user             # A surfboard belongs to a user (owner)
  has_many :bookings           # A surfboard can have many bookings
  has_many :reviews, through: :bookings

  has_one_attached :photo     # For image uploads using Active Storage

  # geocoder stuff
  geocoded_by :location
  after_validation :geocode, if: :will_save_change_to_location?

  # Constants for dropdowns/inclusions
  CATEGORIES = ["Longboard", "Shortboard", "Softboard"].freeze
  TAIL_TYPES = ["Square Tail", "Squash Tail", "Round Tail", "Pin Tail", "Swallow Tail"].freeze
  SURFBOARD_SIZES = (5..10).each_with_object([]) do |feet, sizes|
    (0..11).each do |inches|
      next if feet == 5 && inches == 0
      sizes << "#{feet}'#{inches}\""
    end
  end.freeze

  # Validations
  validates :category, presence: true, inclusion: { in: CATEGORIES }
  validates :size, presence: true, inclusion: { in: SURFBOARD_SIZES }
  validates :tail, presence: true, inclusion: { in: TAIL_TYPES }
  validates :location, presence: true
  validates :price, presence: true, numericality: { greater_than: 0 } # Ensure price is a positive number
end
