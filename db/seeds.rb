# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

puts 'Starting to seed user...'
user = User.create(
  first_name: 'admin_user',
  last_name: 'admin_user_last',
  email: 'admin@admin.com',
  password: 'password123',
  user_type: 'admin',
  is_pending: false,
  confirmed_at: Time.now,
)

# # active users
# for i in 1..10 do
#   User.create!(
#     first_name: "first_name#{i}",
#     last_name: "last_name#{i}",
#     email: "email_active#{i}@email.com",
#     password: "password#{i}",
#     is_pending: false
#   )
# end
# # pending users
# for i in 1..10 do
#   User.create!(
#     first_name: "first_name#{i}",
#     last_name: "last_name#{i}",
#     email: "email_pending#{i}@email.com",
#     password: "password#{i}",
#     is_pending: true
#   )
# end

puts "User: #{user.inspect}"
if user.persisted?
  puts 'User created successfully!'
else
  puts "User creation failed: #{user.errors.full_messages.join(', ')}"
end
puts 'Finished seeding user.'

Stock.create(stock_quantity: 1, price_per_stock: 100.23, company_name: 'Rolls Royce')
Stock.create(stock_quantity: 45, price_per_stock: 157.89, company_name: 'Bugatti ')
Stock.create(stock_quantity: 78, price_per_stock: 32.45, company_name: 'Jeep')
Stock.create(stock_quantity: 12, price_per_stock: 254.75, company_name: 'Maserati')
Stock.create(stock_quantity: 203, price_per_stock: 89.99, company_name: 'Toyota')
Stock.create(stock_quantity: 66, price_per_stock: 121.60, company_name: 'Ford')