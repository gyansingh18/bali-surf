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
  # SURFBOARD_SIZES = (5..10).each_with_object([]) do |feet, sizes|
  #   (0..11).each do |inches|
  #     next if feet == 5 && inches == 0
  #     sizes << "#{feet} ft. #{inches} in."
  #   end
  # end.freeze

  # Validations
  validates :category, presence: true, inclusion: { in: CATEGORIES }
  validates :size, presence: true#, inclusion: { in: SURFBOARD_SIZES }
  validates :tail, presence: true, inclusion: { in: TAIL_TYPES }
  validates :location, presence: true
  validates :price, presence: true, numericality: { greater_than: 0 }

  # sizes =
  #   {
  #   4.0 => "4'0\"",
  #   4.01 => "4'1\"",
  #   4.02 => "4'2\"",
  #   4.03 => "4'3\"",
  #   4.04 => "4'4\"",
  #   4.05 => "4'5\"",
  #   4.06 => "4'6\"",
  #   4.07 => "4'7\"",
  #   4.08 => "4'8\"",
  #   4.09 => "4'9\"",
  #   4.1 => "4'10\"",
  #   4.11 => "4'11\"",
  #   5.0 => "5'0\"",
  #   5.01 => "5'1\"",
  #   5.02 => "5'2\"",
  #   5.03 => "5'3\"",
  #   5.04 => "5'4\"",
  #   5.05 => "5'5\"",
  #   5.06 => "5'6\"",
  #   5.07 => "5'7\"",
  #   5.08 => "5'8\"",
  #   5.09 => "5'9\"",
  #   5.1 => "5'10\"",
  #   5.11 => "5'11\"",
  #   6.0 => "6'0\"",
  #   6.01 => "6'1\"",
  #   6.02 => "6'2\"",
  #   6.03 => "6'3\"",
  #   6.04 => "6'4\"",
  #   6.05 => "6'5\"",
  #   6.06 => "6'6\"",
  #   6.07 => "6'7\"",
  #   6.08 => "6'8\"",
  #   6.09 => "6'9\"",
  #   6.1 => "6'10\"",
  #   6.11 => "6'11\"",
  #   7.0 => "7'0\"",
  #   7.01 => "7'1\"",
  #   7.02 => "7'2\"",
  #   7.03 => "7'3\"",
  #   7.04 => "7'4\"",
  #   7.05 => "7'5\"",
  #   7.06 => "7'6\"",
  #   7.07 => "7'7\"",
  #   7.08 => "7'8\"",
  #   7.09 => "7'9\"",
  #   7.1 => "7'10\"",
  #   7.11 => "7'11\"",
  #   8.0 => "8'0\"",
  #   8.01 => "8'1\"",
  #   8.02 => "8'2\"",
  #   8.03 => "8'3\"",
  #   8.04 => "8'4\"",
  #   8.05 => "8'5\"",
  #   8.06 => "8'6\"",
  #   8.07 => "8'7\"",
  #   8.08 => "8'8\"",
  #   8.09 => "8'9\"",
  #   8.1 => "8'10\"",
  #   8.11 => "8'11\"",
  #   9.0 => "9'0\"",
  #   9.01 => "9'1\"",
  #   9.02 => "9'2\"",
  #   9.03 => "9'3\"",
  #   9.04 => "9'4\"",
  #   9.05 => "9'5\"",
  #   9.06 => "9'6\"",
  #   9.07 => "9'7\"",
  #   9.08 => "9'8\"",
  #   9.09 => "9'9\"",
  #   9.1 => "9'10\"",
  #   9.11 => "9'11\"",
  #   10.0 => "10'0\"",
  #   10.01 => "10'1\"",
  #   10.02 => "10'2\"",
  #   10.03 => "10'3\"",
  #   10.04 => "10'4\"",
  #   10.05 => "10'5\"",
  #   10.06 => "10'6\"",
  #   10.07 => "10'7\"",
  #   10.08 => "10'8\"",
  #   10.09 => "10'9\"",
  #   10.1 => "10'10\"",
  #   10.11 => "10'11\""
  # }
end
