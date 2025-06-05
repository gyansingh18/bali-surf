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
  "Canuck Cove",       # Specific request + allting surfer/beach name
  "Ketut Kaimana"      # Specific request + alliterative surfer/beach name
]

users = user_names.map do |name|
  first_name, last_name = name.split
  last_name ||= "Surfer" # Default last name if only one word provided

  # --- Handle specific overrides ---
  email_to_use = ""
  password_to_use = ""

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

# ... (rest of your seed file remains the same) ...

# --- Designate Surfboard Owners ---
# Let's pick the first 3 users to be surfboard owners
surfboard_owners = users.sample(3)
puts "Designated #{surfboard_owners.count} users as surfboard owners."

# --- Create Surfboards ---
puts "Creating surfboards..."
surfboards = []
bali_locations = [
  "Canggu", "Uluwatu", "Kuta", "Seminyak", "Padang Padang",
  "Bingin", "Nusa Dua", "Sanur", "Keramas", "Medewi"
]

surfboard_owners.each do |owner|
  10.times do
    surfboard = Surfboard.new(
      user: owner,
      category: Surfboard::CATEGORIES.sample,
      size: "#{(Faker::Number.decimal(l_digits: 1, r_digits: 1) + 5).round(1)}'", # e.g., "5.5'" to "10.0'"
      tail: Surfboard::TAIL_TYPES.sample,
      location: bali_locations.sample,
      price: Faker::Commerce.price(range: 10..50).to_i # Price per day
    )
    surfboard.save!
    surfboards << surfboard
  end
end

puts "Created #{surfboards.count} surfboards."

# --- Create Bookings ---
puts "Creating bookings..."
# Users who don't own surfboards will be the ones making bookings
booking_users = users - surfboard_owners

50.times do
  user = booking_users.sample
  surfboard = surfboards.sample

  # Ensure booking dates are in the future for "pending" status, or in the past for reviews
  start_date = Faker::Date.between(from: Date.today, to: 3.months.from_now)
  end_date = start_date + Faker::Number.between(from: 2, to: 10).days # Booking for 2 to 10 days

  total_price = (end_date - start_date).to_i * surfboard.price

  Booking.create!(
    user: user,
    surfboard: surfboard,
    start_date: start_date,
    end_date: end_date,
    total_price: total_price,
    status: "pending" # All new bookings start as pending
  )
end
puts "Created 50 bookings."

# --- Create Reviews for past bookings ---
puts "Creating reviews for relevant bookings..."
# Find bookings that have ended to be eligible for reviews
bookings_for_review = Booking.where("end_date < ?", Date.today).sample(Faker::Number.between(from: 10, to: 20)) # Create 10-20 reviews

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

bookings_for_review.each do |booking|
  Review.create!(
    booking: booking,
    rating: Review::RATINGS.sample,
    comment: review_comments.sample
  )
  # Optionally, you could mark the booking status as 'completed' here if you have such a status
end

puts "Created #{Review.count} reviews."
puts "Seed complete!"
