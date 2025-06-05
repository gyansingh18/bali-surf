require "open-uri" # Make sure to require open-uri

puts "Cleaning database..."
Booking.destroy_all
# Important: Destroy Surfboard first if it has photos, as Active Storage attachments are associated
# with the record. If photos are still attached after destroying records, you might need
# `ActiveStorage::Attachment.all.each(&:purge)` or similar for a full purge in development,
# but destroying records should generally handle attachments.
Surfboard.destroy_all
User.destroy_all
puts "Database cleaned!"

puts "Creating users..."
ashley = User.create!(email: "ashley@gmail.com", password: "password@123")
alizee = User.create!(email: "alizee@gmail.com", password: "password@123")
clint = User.create!(email: "clint@gmail.com", password: "password@123")
gyan = User.create!(email: "gyan@gmail.com", password: "password@123")
jannis = User.create!(email: "jannis@gmail.com", password: "password@123")
puts "Users created!"

puts "Creating surfboards and attaching photos..."

# Surfboard 1
board_one = Surfboard.new(
  price: 199.99,
  category: "Longboard",
  tail: "Swallow Tail",
  size: 9,
  user: alizee,
  location: "Canggu Beach, Bali"
)
file_one = URI.open("https://cdn.shopify.com/s/files/1/0411/9757/files/ULTIMATE-LONGBOARD-SURFBOARD-TEAL-CHEVRON-_EPOXY_ed15fba6-2e99-437a-86fb-97ecb7e3248d_1024x1024.jpg?v=1620690287")
board_one.photo.attach(io: file_one, filename: "board_one.jpg", content_type: "image/jpeg")
board_one.save!
puts "Created board_one with photo."

# Surfboard 2
board_two = Surfboard.new(
  price: 299.99,
  category: "Shortboard",
  tail: "Squash Tail",
  size: 5.8,
  user: alizee,
  location: "Seminyak, Bali"
)
file_two = URI.open("https://bellon-surfboards.com/wp-content/uploads/2019/09/Shortboard-Roundtail1.jpg")
board_two.photo.attach(io: file_two, filename: "board_two.jpg", content_type: "image/jpeg")
board_two.save!
puts "Created board_two with photo."

# Surfboard 3
board_three = Surfboard.new(
  price: 399.99,
  category: "Longboard",
  tail: "Square Tail",
  size: 7.2,
  user: alizee,
  location: "Kuta Beach, Bali"
)
file_three = URI.open("https://cdn.shopify.com/s/files/1/0411/9757/files/POACHER-FUNBOARD-SURFBOARD-AQUA-DIP-_HYBRID-EPOXY-SOFTTOP_1024x1024.jpg?v=1620690327")
board_three.photo.attach(io: file_three, filename: "board_three.jpg", content_type: "image/jpeg")
board_three.save!
puts "Created board_three with photo."

# Surfboard 4
board_four = Surfboard.new(
  price: 499.99,
  category: "Softboard",
  tail: "Pin Tail",
  size: 5.8,
  user: alizee,
  location: "Sanur, Bali"
)
file_four = URI.open("https://cdn.shopify.com/s/files/1/0411/9757/files/CODFATHER-FISH-SURFBOARD-TEAL-DIP-_EPOXY_1024x1024.jpg?v=1620690144")
board_four.photo.attach(io: file_four, filename: "board_four.jpg", content_type: "image/jpeg")
board_four.save!
puts "Created board_four with photo."

puts "Surfboards created and photos attached!"

puts "Creating bookings..."
Booking.create!(
  start_date: Date.today,
  end_date: Date.today,
  total_price: 199.99,
  user: ashley,
  surfboard: board_one,
  status: "pending" # Added status as it's required by your model
)

booking_two = Booking.create(
  start_date: Date.yesterday,
  end_date: Date.yesterday,
  total_price: 299.99,
  user: ashley,
  surfboard: board_two,
  status: "accepted" # Added status as it's required by your model
)

booking_three = Booking.create(
  start_date: Date.today,
  end_date: Date.today,
  total_price: 299.99,
  user: alizee,
  surfboard: board_two
)

Review.create(
  rating: 4,
  comment: "You know, you don't have to win to be a winner.",
  booking: booking_two
)

Review.create(
  rating: 10,
  comment: "Never turn your back on the ocean.",
  booking: booking_three
)
puts "Bookings created!"

puts "Seed complete!"
