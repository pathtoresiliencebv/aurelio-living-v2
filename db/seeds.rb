# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

Spree::Core::Engine.load_seed if defined?(Spree::Core)

# Setup default admin user for Aurelio Living
puts "🔧 Setting up Aurelio Living admin user..."
admin = Spree::AdminUser.find_or_initialize_by(email: 'admin@aurelioliving.com')

if admin.new_record?
  admin.password = 'Admin123!'
  admin.password_confirmation = 'Admin123!'
  admin.save!
  puts "✅ Admin user created: admin@aurelioliving.com"
else
  puts "✅ Admin user already exists: admin@aurelioliving.com"
end