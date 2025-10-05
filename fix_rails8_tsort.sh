#!/bin/bash

echo "🔧 Fixing tsort LoadError for Rails 8.0.0..."

# Navigate to project directory
cd "/home/jason/AURELIO LIVING/spree_starter"

echo "📋 Current directory: $(pwd)"

# Check Ruby version
echo "🔍 Ruby version:"
ruby --version

# Check if we're in the right directory
if [ ! -f "Gemfile" ]; then
    echo "❌ Error: Gemfile not found. Are you in the correct directory?"
    exit 1
fi

echo "🧹 Step 1: Cleaning up..."
rm -f Gemfile.lock
bundle clean --force

echo "📦 Step 2: Updating bundler..."
gem update bundler

echo "🔧 Step 3: Reinstalling gems with specific tsort version..."
bundle install

echo "🔍 Step 4: Checking tsort gem..."
gem list tsort

echo "🧪 Step 5: Testing tsort loading..."
ruby -e "
begin
  require 'tsort'
  puts '✅ tsort gem loaded successfully'
rescue LoadError => e
  puts '❌ tsort LoadError: ' + e.message
  puts 'Installing tsort gem directly...'
  system('gem install tsort')
  require 'tsort'
  puts '✅ tsort gem installed and loaded'
end
"

echo "🚀 Step 6: Testing Rails application..."
bin/rails --version

echo "✅ Fix completed! Try running 'bin/setup' again."
