#!/bin/bash

echo "🔍 Diagnosing web application errors..."

# Navigate to project directory
cd "/home/jason/AURELIO LIVING/spree_starter"

echo "📋 Current directory: $(pwd)"

echo "🧪 Step 1: Testing Rails application loading..."
ruby -e "
begin
  require_relative 'config/application'
  puts '✅ Rails application loads successfully'
rescue => e
  puts '❌ Rails loading failed: ' + e.message
  puts 'Backtrace:'
  puts e.backtrace.first(5)
end
"

echo ""
echo "🗄️ Step 2: Testing database connection..."
bin/rails runner "
begin
  ActiveRecord::Base.connection.execute('SELECT 1')
  puts '✅ Database connection successful'
rescue => e
  puts '❌ Database connection failed: ' + e.message
end
"

echo ""
echo "📦 Step 3: Checking Spree installation..."
bin/rails runner "
begin
  require 'spree'
  puts '✅ Spree gem loaded successfully'
  puts 'Spree version: ' + Spree.version
rescue => e
  puts '❌ Spree loading failed: ' + e.message
end
"

echo ""
echo "🌐 Step 4: Testing routes..."
bin/rails routes | head -10

echo ""
echo "📊 Step 5: Checking environment..."
echo "RAILS_ENV: $RAILS_ENV"
echo "DATABASE_URL: ${DATABASE_URL:0:50}..."

echo ""
echo "✅ Diagnosis completed!"
echo ""
echo "💡 Common solutions:"
echo "1. Run: bin/rails db:seed"
echo "2. Run: bin/rails assets:precompile"
echo "3. Run: bin/rails spree:install"
echo "4. Check your .env file for DATABASE_URL"
