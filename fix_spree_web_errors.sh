#!/bin/bash

echo "🔧 Fixing common Spree web application errors..."

# Navigate to project directory
cd "/home/jason/AURELIO LIVING/spree_starter"

echo "📋 Current directory: $(pwd)"

echo "🧹 Step 1: Cleaning up..."
rm -rf tmp/cache/*
rm -rf public/assets/*

echo "📦 Step 2: Precompiling assets..."
bin/rails assets:precompile

echo "🗄️ Step 3: Checking database..."
bin/rails db:migrate:status

echo "🌱 Step 4: Loading sample data..."
bin/rails db:seed

echo "🔧 Step 5: Setting up Spree..."
bin/rails spree:install

echo "🧪 Step 6: Testing Rails routes..."
bin/rails routes | head -20

echo "✅ Spree setup completed!"
echo ""
echo "🌐 Your Spree store should now be available at:"
echo "   http://localhost:3001"
echo ""
echo "📱 Admin panel:"
echo "   http://localhost:3001/admin"
echo ""
echo "🔑 Default admin credentials:"
echo "   Email: admin@example.com"
echo "   Password: spree123"
