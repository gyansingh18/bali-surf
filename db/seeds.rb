# db/seeds.rb

require 'faker'

puts "Cleaning database..."
Review.destroy_all
Booking.destroy_all
Surfboard.destroy_all
User.destroy_all
puts "Database cleaned!"

# --- Create Users ---
puts "Creating users..."

user_names = [
  "Ashley Azure",      # Group member + alliterative surfer/beach name
  "Clint Coral",       # Group member + alliterative surfer/beach name
  "Gyan Gnarley",      # Group member + alliterative surfer/beach name
  "Jannis Jetty",      # Group member + alliterative surfer/beach name
  "Alizee Aqua",       # Group member + alliterative surfer/beach name
  "Christina Coast",   # Group member + alliterative surfer/beach name
  "Dani Dune",         # Group member + alliterative surfer/beach name
  "Bogan Barrel",      # Specific request + alliterative surfer/beach name
  "Canuck Cove",       # Specific request + alliterative surfer/beach name
  "Ketut Kaimana"      # Specific request + alliterative surfer/beach name
]

users = user_names.map do |name|
  first_name, last_name = name.split
  last_name ||= "Surfer" # Default last name if only one word provided

  # --- Handle specific overrides ---
  email_to_use = ""
  password_to_use = "password123"

  case name
  when "Ashley Azure"
    email_to_use = "ashley@gmail.com"
    password_to_use = "password@123"
  when "Alizee Aqua"
    email_to_use = "alizee@gmail.com"
    password_to_use = "password@123"
  else
    # Default logic for other users
    email_to_use = "#{first_name.downcase}.#{last_name.downcase.gsub(' ', '')}@example.com"
    password_to_use = 'password'
  end
  # --- End specific overrides ---

  User.create!(
    first_name: first_name,
    last_name: last_name,
    email: email_to_use,
    password: password_to_use
  )
end

puts "Created #{users.count} users."


# --- Designate Surfboard Owners ---
# Let's pick the first 3 users to be surfboard owners
surfboard_owners = users.sample(3)
puts "Designated #{surfboard_owners.count} users as surfboard owners."

# --- Create Surfboards ---
puts "Creating surfboards..."
surfboards = []
bali_locations = [
  "Canggu, Bali, Indonesia",
  "Uluwatu, Bali, Indonesia",
  "Kuta, Bali, Indonesia",
  "Seminyak, Bali, Indonesia",
  "Padang Padang, Bali, Indonesia",
  "Bingin, Bali, Indonesia",
  "Sanur, Bali, Indonesia",
  "Keramas, Bali, Indonesia",
  "Medewi, Bali, Indonesia",
  "Echo Beach, Bali, Indonesia",
  "Balangan, Bali, Indonesia",
  "Dreamland, Bali, Indonesia",
  "Jimbaran, Bali, Indonesia",
  "Legian, Bali, Indonesia",
  "Suluban Beach, Bali, Indonesia", # Another specific surf spot
  "Green Bowl Beach, Bali, Indonesia" # Very specific beach
]

board_image_links = [
  "https://images.unsplash.com/photo-1531722569936-825d3dd91b15?q=80&w=2070&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D"
]

surfboard_owners.each do |owner|
  10.times do
    link = board_image_links.sample
    file = URI.parse(link).open
    surfboard = Surfboard.new(
      user: owner,
      category: Surfboard::CATEGORIES.sample,
      size: "#{(Faker::Number.decimal(l_digits: 1, r_digits: 1) + 5).round(1)}'", # e.g., "5.5'" to "10.0'"
      tail: Surfboard::TAIL_TYPES.sample,
      location: bali_locations.sample,
      price: Faker::Commerce.price(range: 10..50).to_i # Price per day
    )
    surfboard.photo.attach(io: file, filename: "photo.png", content_type: "image/png")
    surfboard.save!
    surfboards << surfboard
  end
end

puts "Created #{surfboards.count} surfboards."

# --- Create Bookings ---
puts "Creating bookings..."
# Users who don't own surfboards will be the ones making bookings
booking_users = users - surfboard_owners

# We will create bookings that are both in the past and in the future.
# Bookings in the past will be eligible for reviews.

# Determine a target number of past bookings for each surfboard to ensure enough for reviews
# Assuming each owner has 10 surfboards, and we need 5 reviews per surfboard,
# we need at least 5 past bookings per surfboard.
# Total surfboards = 3 owners * 10 surfboards/owner = 30 surfboards
# Target total past bookings = 30 surfboards * 5 bookings/surfboard = 150 bookings
# Since we only create 50 bookings in total, we'll try to prioritize past bookings.

bookings_to_create_count = 100 # Increased total bookings to ensure enough for reviews
past_booking_target = 5 # Number of past bookings we aim for per surfboard

bookings_created_count = 0
while bookings_created_count < bookings_to_create_count
  user = booking_users.sample
  surfboard = surfboards.sample

  start_date = nil
  end_date = nil
  status = nil

  # Check if this surfboard already has enough past bookings for reviews
  # and if we still need to create future bookings
  existing_past_bookings_for_surfboard = Booking.where(surfboard: surfboard, status: "accepted")
                                                .where("end_date < ?", Date.today)
                                                .count

  if existing_past_bookings_for_surfboard < past_booking_target && bookings_created_count < (surfboards.count * past_booking_target)
    # Create a past booking if this surfboard needs more for reviews
    start_date = Faker::Date.between(from: 3.months.ago, to: 1.month.ago)
    end_date = start_date + Faker::Number.between(from: 2, to: 10).days
    status = "accepted" # Using an existing valid status for past bookings
  else
    # Create a future booking otherwise
    start_date = Faker::Date.between(from: Date.today, to: 3.months.from_now)
    end_date = start_date + Faker::Number.between(from: 2, to: 10).days
    status = "pending" # Using an existing valid status for future bookings
  end

  total_price = (end_date - start_date).to_i * surfboard.price

  Booking.create!(
    user: user,
    surfboard: surfboard,
    start_date: start_date,
    end_date: end_date,
    total_price: total_price,
    status: status
  )
  bookings_created_count += 1
end
puts "Created #{Booking.count} bookings."

# --- Create Reviews for past bookings ---
puts "Creating reviews for relevant bookings..."

review_comments = [
  "Great board, perfect for the waves!",
  "Had an amazing time, surfboard was in excellent condition.",
  "Smooth ride, really enjoyed it.",
  "Excellent rental, highly recommend.",
  "The board was exactly what I needed.",
  "Fantastic experience, board felt great.",
  "Good value for money.",
  "Met expectations, solid board.",
  "Perfect for learning.",
  "Owner was very helpful."
]

# Iterate through each surfboard to ensure it gets reviews
total_reviews_created = 0
surfboards.each do |surfboard|
  # Find all 'accepted' bookings for this surfboard that have ended
  eligible_bookings_for_surfboard = Booking.where(surfboard: surfboard, status: "accepted")
                                           .where("end_date < ?", Date.today)
                                           .order(end_date: :asc) # Order by ascending date to get older bookings first

  # Select up to 5 of these bookings to create reviews for
  # Using `first(5)` after ordering by `asc` to get the earliest 5 past bookings
  bookings_to_review_for_this_surfboard = eligible_bookings_for_surfboard.first(5)

  bookings_to_review_for_this_surfboard.each do |booking|
    # Only create a review if one doesn't already exist for this booking
    unless booking.review.present?
      Review.create!(
        booking: booking,
        rating: Faker::Number.between(from: 8, to: 10), # Set rating between 8 and 10
        comment: review_comments.sample
      )
      total_reviews_created += 1
    end
  end
end

puts "Created #{total_reviews_created} reviews."
puts "Seed complete!"
