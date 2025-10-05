#!/bin/bash

echo "🔧 Fixing net-protocol LoadError in Rails 8.0.0..."

# Navigate to project directory
cd "/home/jason/AURELIO LIVING/spree_starter"

echo "📋 Current directory: $(pwd)"

# Check if we're in the right directory
if [ ! -f "Gemfile" ]; then
    echo "❌ Error: Gemfile not found. Are you in the correct directory?"
    exit 1
fi

echo "🧹 Step 1: Complete gem cleanup..."
rm -f Gemfile.lock
bundle clean --force

echo "📦 Step 2: Installing missing net-protocol gem..."
gem install net-protocol

echo "🔧 Step 3: Installing missing net-http gem..."
gem install net-http

echo "📦 Step 4: Reinstalling all gems..."
bundle install

echo "🧪 Step 5: Testing net-protocol loading..."
ruby -e "
begin
  require 'net/protocol'
  puts '✅ net-protocol gem loaded successfully'
rescue LoadError => e
  puts '❌ net-protocol LoadError: ' + e.message
  puts 'Installing net-protocol gem directly...'
  system('gem install net-protocol')
  require 'net/protocol'
  puts '✅ net-protocol gem installed and loaded'
end
"

echo "🧪 Step 6: Testing sentry-ruby loading..."
ruby -e "
begin
  require 'sentry-ruby'
  puts '✅ sentry-ruby gem loaded successfully'
rescue LoadError => e
  puts '❌ sentry-ruby LoadError: ' + e.message
end
"

echo "🚀 Step 7: Testing Rails application..."
bin/rails --version

echo "✅ Fix completed! Try running 'bin/setup' again."
