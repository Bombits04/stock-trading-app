# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
for i in 1..10 do
  User.create!(
    first_name: "first_name#{i}",
    last_name: "last_name#{i}",
    email: "email#{i}@email.com",
    password: "password#{i}",
    is_pending: false
  )
end
