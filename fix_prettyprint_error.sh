#!/bin/bash

echo "🔧 Fixing prettyprint LoadError in Spree gem..."

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

echo "📦 Step 2: Installing missing prettyprint gem..."
gem install prettyprint

echo "🔧 Step 3: Installing other missing core gems..."
gem install pp
gem install rexml
gem install stringio

echo "📦 Step 4: Reinstalling all gems..."
bundle install

echo "🧪 Step 5: Testing prettyprint loading..."
ruby -e "
begin
  require 'prettyprint'
  puts '✅ prettyprint gem loaded successfully'
rescue LoadError => e
  puts '❌ prettyprint LoadError: ' + e.message
  puts 'Installing prettyprint gem directly...'
  system('gem install prettyprint')
  require 'prettyprint'
  puts '✅ prettyprint gem installed and loaded'
end
"

echo "🧪 Step 6: Testing Spree loading..."
ruby -e "
begin
  require 'spree'
  puts '✅ Spree gem loaded successfully'
rescue LoadError => e
  puts '❌ Spree LoadError: ' + e.message
end
"

echo "🚀 Step 7: Testing Rails application..."
bin/rails --version

echo "✅ Fix completed! Try running 'bin/setup' again."
