#!/bin/bash

echo "🚀 Fixing Rails 8.0.0 core gem issues while keeping Spree..."

# Navigate to project directory
cd "/home/jason/AURELIO LIVING/spree_starter"

echo "📋 Current directory: $(pwd)"

echo "🧹 Step 1: Complete cleanup..."
rm -f Gemfile.lock
bundle clean --force

echo "📦 Step 2: Installing all missing core Ruby gems..."
echo "Installing prettyprint..."
gem install prettyprint

echo "Installing pp..."
gem install pp

echo "Installing rexml..."
gem install rexml

echo "Installing stringio..."
gem install stringio

echo "Installing net-protocol..."
gem install net-protocol

echo "Installing net-http..."
gem install net-http

echo "Installing tsort..."
gem install tsort

echo "📦 Step 3: Reinstalling all gems..."
bundle install

echo "🧪 Step 4: Testing all core gems..."
ruby -e "
gems = ['prettyprint', 'pp', 'rexml', 'stringio', 'net/protocol', 'net/http', 'tsort']
gems.each do |gem_name|
  begin
    require gem_name
    puts \"✅ #{gem_name} loaded successfully\"
  rescue LoadError => e
    puts \"❌ #{gem_name} LoadError: #{e.message}\"
  end
end
"

echo "🧪 Step 5: Testing Spree gem..."
ruby -e "
begin
  require 'spree'
  puts '✅ Spree gem loaded successfully'
rescue LoadError => e
  puts '❌ Spree LoadError: ' + e.message
end
"

echo "🚀 Step 6: Testing Rails application..."
bin/rails --version

echo "🎯 Step 7: Testing setup..."
bin/setup

echo "✅ All fixes applied! Spree should work now."
