#!/bin/bash

echo "🔧 Fixing admin login CSRF error..."

# Navigate to project directory
cd "/home/jason/AURELIO LIVING/spree_starter"

echo "📋 Current directory: $(pwd)"

echo "🧹 Step 1: Clearing browser cache and sessions..."
echo "Please clear your browser cache and cookies for localhost:3001"

echo "🗄️ Step 2: Checking database..."
bin/rails runner "
puts 'Database connection: ' + (ActiveRecord::Base.connection.active? ? 'OK' : 'FAILED')
puts 'Spree tables: ' + ActiveRecord::Base.connection.tables.select { |t| t.start_with?('spree_') }.count.to_s
"

echo "👤 Step 3: Creating/checking admin user..."
bin/rails runner "
begin
  # Check if admin user exists
  admin_user = Spree::AdminUser.find_by(email: 'admin@example.com')
  
  if admin_user
    puts '✅ Admin user exists: ' + admin_user.email
  else
    puts '❌ Admin user not found, creating...'
    admin_user = Spree::AdminUser.create!(
      email: 'admin@example.com',
      password: 'spree123',
      password_confirmation: 'spree123'
    )
    puts '✅ Admin user created'
  end
rescue => e
  puts '❌ Error with admin user: ' + e.message
end
"

echo "🌱 Step 4: Loading sample data..."
bin/rails db:seed

echo "🔧 Step 5: Restarting server..."
echo "Please restart your Rails server (Ctrl+C then bin/rails server)"

echo "✅ Admin login fix completed!"
echo ""
echo "🌐 Try again:"
echo "   1. Clear browser cache/cookies"
echo "   2. Go to: http://localhost:3001/admin"
echo "   3. Login with: admin@example.com / spree123"
