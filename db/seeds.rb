# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

puts "Starting to seed user..."
user = User.create(
  email: 'admin@admin.com',
  password: 'password123',
  user_type: 'admin'
)
puts "User: #{user.inspect}"
if user.persisted?
  puts "User created successfully!"
else
  puts "User creation failed: #{user.errors.full_messages.join(", ")}"
end
puts "Finished seeding user."
