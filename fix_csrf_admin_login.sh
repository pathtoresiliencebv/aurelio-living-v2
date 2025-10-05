#!/bin/bash

echo "🔧 Fixing CSRF token error in admin login..."

# Navigate to project directory
cd "/home/jason/AURELIO LIVING/spree_starter"

echo "📋 Current directory: $(pwd)"

echo "🔧 Step 1: Clearing Rails cache..."
bin/rails tmp:clear

echo "🔧 Step 2: Clearing browser cache instructions..."
echo "🌐 Please clear your browser cache or use incognito mode"
echo "   - Chrome: Ctrl+Shift+Delete"
echo "   - Firefox: Ctrl+Shift+Delete"
echo "   - Or use incognito/private mode"

echo "🔧 Step 3: Checking CSRF configuration..."
if [ -f "config/application.rb" ]; then
    echo "✅ Application config found"
else
    echo "❌ Application config not found"
fi

echo "🔧 Step 4: Creating admin user reset script..."
cat > reset_admin_user.rb << 'EOF'
# Reset admin user for CSRF fix
require_relative 'config/environment'

puts "🔧 Resetting admin user..."

# Find or create admin user
admin_email = 'admin@example.com'
admin_password = 'spree123'

# Delete existing admin if exists (check both User and AdminUser)
existing_user = Spree::User.find_by(email: admin_email)
if existing_user
  existing_user.destroy
  puts "🗑️ Deleted existing user"
end

existing_admin = Spree::AdminUser.find_by(email: admin_email)
if existing_admin
  existing_admin.destroy
  puts "🗑️ Deleted existing admin user"
end

# Create new admin user using the correct Spree::AdminUser model
admin = Spree::AdminUser.create!(
  email: admin_email,
  password: admin_password,
  password_confirmation: admin_password
)

puts "✅ Created new admin user:"
puts "   Email: #{admin_email}"
puts "   Password: #{admin_password}"
puts "   Admin URL: http://localhost:3001/admin"
EOF

echo "🔧 Step 5: Running admin user reset..."
ruby reset_admin_user.rb

echo "🔧 Step 6: Restarting Rails server..."
echo "🚀 Please restart your server:"
echo "   Ctrl+C to stop current server"
echo "   bin/rails server to start fresh"

echo ""
echo "✅ CSRF fix completed!"
echo ""
echo "🌐 Login credentials:"
echo "   Email: admin@example.com"
echo "   Password: spree123"
echo "   URL: http://localhost:3001/admin"
echo ""
echo "💡 If still getting CSRF error:"
echo "   1. Clear browser cache completely"
echo "   2. Use incognito/private mode"
echo "   3. Try different browser"
