Rails app generated with [lewagon/rails-templates](https://github.com/lewagon/rails-templates), created by the [Le Wagon coding bootcamp](https://www.lewagon.com) team.
Bali Surf
Bali Surf is a Ruby on Rails web application designed for surfers and travelers to discover the best surf spots around Bali. It combines real-time surf conditions, location-based search, and a curated database of spots to make trip planning easier.
Note: This is a practice/learning project rebuilt as part of my Le Wagon journey, hosted inside the Clint Ryan repository.
Features
User Authentication – Sign up, log in, and manage profiles (Devise).
Surf Spot Directory – Browse spots with images, difficulty level, and best season.
Interactive Map – Mapbox integration to display surf spot locations.
Search & Filters – Search by spot name, skill level, or location.
Surf Spot Details – View wave type, tide information, and local tips.
Responsive Design – Works seamlessly on desktop and mobile.
Tech Stack
Backend: Ruby on Rails 7
Frontend: HTML, SCSS, JavaScript (ES6)
Auth: Devise
Database: PostgreSQL
Maps: Mapbox API
Hosting: Heroku
Set up the database:
rails db:create db:migrate db:seed
Create a .env file and add your Mapbox API key:
MAPBOX_API_KEY=your_mapbox_key_here
Start the server:
rails s
Visit http://localhost:3000 in your browser.
My Contribution
While working on Bali Surf, I implemented:
Devise authentication for user accounts.
Mapbox integration for mapping surf spots.
Search and filtering system for surf spot directory.
Frontend styling for surf spot cards and detail pages.
Seed data creation with real Bali surf spot info.
Mobile-friendly responsive layouts.
Credits
Gyan Singh – Developer (Learning Rebuild)
Le Wagon Bali Batch #xxx for guidance and inspiration
