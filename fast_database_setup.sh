#!/bin/bash

echo "🚀 Fast database setup for Spree..."

# Navigate to project directory
cd "/home/jason/AURELIO LIVING/spree_starter"

echo "📋 Current directory: $(pwd)"

echo "🧹 Step 1: Cleaning up..."
rm -f Gemfile.lock
bundle clean --force

echo "📦 Step 2: Installing missing gems..."
gem install prettyprint pp rexml stringio net-protocol net-http tsort

echo "📦 Step 3: Reinstalling gems..."
bundle install

echo "🧪 Step 4: Testing Rails..."
bin/rails --version

echo "🗄️ Step 5: Database setup (this may take a few minutes)..."
echo "Creating database..."
bin/rails db:create

echo "Running migrations..."
bin/rails db:migrate

echo "Loading sample data..."
bin/rails db:seed

echo "✅ Database setup completed!"
echo "🚀 Now try: bin/setup"
