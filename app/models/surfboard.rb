# app/models/surfboard.rb
class Surfboard < ApplicationRecord
  # Associations
  belongs_to :user             # A surfboard belongs to a user (owner)
  has_many :bookings           # A surfboard can have many bookings

  has_one_attached :image     # For image uploads using Active Storage

  # geocoder stuff
  geocoded_by :location
  after_validation :geocode, if: :will_save_change_to_location?

  # Constants for dropdowns/inclusions
  CATEGORIES = ["Longboard", "Shortboard", "Softboard"].freeze
  TAIL_TYPES = ["Square Tail", "Squash Tail", "Round Tail", "Pin Tail", "Swallow Tail"].freeze
  # CONDITIONS = ["Brand New", "Like New", "Excellent", "Good", "Fair", "Poor"].freeze # Added based on prior discussion

  # Validations
  validates :category, presence: true, inclusion: { in: CATEGORIES }
  validates :size, presence: true
  validates :tail, presence: true, inclusion: { in: TAIL_TYPES }
  validates :location, presence: true
  validates :price, presence: true, numericality: { greater_than: 0 } # Ensure price is a positive number

  # # Optional validations for description and condition (if you added these fields)
  # # These 'if' conditions ensure the validation only runs if the attribute is present
  # # (so you don't get validation errors if these columns aren't in the DB yet)
  # validates :description, presence: true, length: { minimum: 20, maximum: 500 }, if: :description_present?
  # validates :condition, presence: true, inclusion: { in: CONDITIONS }, if: :condition_present?

  # private

  # # Helper methods for conditional validations
  # def description_present?
  #   attribute_present?(:description)
  # end

  # def condition_present?
  #   attribute_present?(:condition)
  # end
end
