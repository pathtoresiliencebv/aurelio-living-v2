#!/usr/bin/env ruby
# Reset Admin Password Script
# Usage: rails runner reset_admin_password.rb

puts "🔧 Resetting admin user..."

# Find or create admin user
admin = Spree::AdminUser.first_or_create!(
  email: 'admin@aurelioliving.com'
) do |user|
  user.password = 'Admin123!'
  user.password_confirmation = 'Admin123!'
end

# Update password
admin.update!(
  password: 'Admin123!',
  password_confirmation: 'Admin123!'
)

puts "✅ Admin user ready!"
puts "   Email: #{admin.email}"
puts "   Password: Admin123!"
puts ""
puts "🔗 Login at: https://aurelio-living-v2-upgraded.onrender.com/admin_users/login"
