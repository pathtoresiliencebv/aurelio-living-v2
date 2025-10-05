#!/bin/bash

echo "🚀 Quick fix for all gem loading issues..."

# Navigate to project directory
cd "/home/jason/AURELIO LIVING/spree_starter"

echo "1. Cleaning up everything..."
rm -f Gemfile.lock
bundle clean --force

echo "2. Installing missing gems directly..."
gem install net-protocol
gem install net-http
gem install tsort

echo "3. Reinstalling all gems..."
bundle install

echo "4. Testing Rails..."
bin/rails --version

echo "5. Testing setup..."
bin/setup

echo "✅ All fixes applied! Rails should work now."
