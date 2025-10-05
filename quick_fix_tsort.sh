#!/bin/bash

echo "🚀 Quick fix for tsort LoadError..."

# Navigate to project directory
cd "/home/jason/AURELIO LIVING/spree_starter"

echo "1. Removing Gemfile.lock..."
rm -f Gemfile.lock

echo "2. Cleaning bundle cache..."
bundle clean --force

echo "3. Reinstalling gems..."
bundle install

echo "4. Testing tsort gem..."
ruby -e "require 'tsort'; puts '✅ tsort gem works!'"

echo "5. Testing Rails..."
bin/rails --version

echo "✅ Done! Now try: bin/setup"
