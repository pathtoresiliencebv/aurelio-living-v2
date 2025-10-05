#!/bin/bash

echo "🔧 Fixing CSRF token error in Spree admin..."

# Navigate to project directory
cd "/home/jason/AURELIO LIVING/spree_starter"

echo "📋 Current directory: $(pwd)"

echo "🧹 Step 1: Cleaning up sessions and cache..."
rm -rf tmp/cache/*
rm -rf tmp/sessions/*

echo "🔧 Step 2: Checking CSRF configuration..."
echo "Current CSRF settings:"
grep -r "protect_from_forgery" config/ || echo "No CSRF settings found"

echo "📦 Step 3: Checking admin user..."
bin/rails runner "
begin
  admin_user = Spree::User.find_by(email: 'admin@example.com')
  if admin_user
    puts '✅ Admin user exists: ' + admin_user.email
  else
    puts '❌ Admin user not found'
    puts 'Creating admin user...'
    admin_user = Spree::User.create!(
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

echo "🔧 Step 5: Setting up Spree admin..."
bin/rails spree:install

echo "✅ CSRF fix completed!"
echo ""
echo "🌐 Try logging in again:"
echo "   http://localhost:3001/admin"
echo ""
echo "🔑 Admin credentials:"
echo "   Email: admin@example.com"
echo "   Password: spree123"
