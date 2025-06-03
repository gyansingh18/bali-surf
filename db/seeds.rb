# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
Booking.destroy_all
User.destroy_all
Surfboard.destroy_all

ashley = User.create(email: "ashley@gmail.com",password:"password@123")
alizee = User.create(email: "alizee@gmail.com",password:"password@123")

board_one = Surfboard.create!(category: "Longboard", tail: "Round", size: 9, user_id: alizee.id, image_url: "https://cdn.shopify.com/s/files/1/0411/9757/files/ULTIMATE-LONGBOARD-SURFBOARD-TEAL-CHEVRON-_EPOXY_ed15fba6-2e99-437a-86fb-97ecb7e3248d_1024x1024.jpg?v=1620690287")
board_two = Surfboard.create(category:"Shortboard", tail: "Pin", size: 5.8, user: alizee, image_url: "https://bellon-surfboards.com/wp-content/uploads/2019/09/Shortboard-Roundtail1.jpg")
Surfboard.create(category:"Longboard", tail: "Fish", size: 7.2, user: alizee, image_url: "https://cdn.shopify.com/s/files/1/0411/9757/files/POACHER-FUNBOARD-SURFBOARD-AQUA-DIP-_HYBRID-EPOXY-SOFTTOP_1024x1024.jpg?v=1620690327")
Surfboard.create(category:"Softboard", tail: "Round", size: 5.8, user: alizee, image_url: "https://cdn.shopify.com/s/files/1/0411/9757/files/CODFATHER-FISH-SURFBOARD-TEAL-DIP-_EPOXY_1024x1024.jpg?v=1620690144")

Booking.create(
  start_date: Date.today,
  end_date: Date.today,
  total_price: 50,
  user: ashley,
  surfboard: board_one
)

Booking.create(
  start_date: Date.yesterday,
  end_date: Date.yesterday,
  total_price: 100,
  user: ashley,
  surfboard: board_two
)
