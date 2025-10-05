#!/bin/bash

echo "🔧 Fixing tsort LoadError in Rails application..."

# Navigate to project directory
cd "/home/jason/AURELIO LIVING/spree_starter"

echo "📋 Current directory: $(pwd)"

# Check if we're in the right directory
if [ ! -f "Gemfile" ]; then
    echo "❌ Error: Gemfile not found. Are you in the correct directory?"
    exit 1
fi

echo "🔍 Checking current gem status..."
bundle list | grep tsort || echo "tsort not found in bundle list"

echo "🧹 Cleaning up gem cache and lock file..."
rm -f Gemfile.lock
bundle clean --force

echo "📦 Reinstalling gems..."
bundle install

echo "🔍 Checking tsort gem specifically..."
gem list tsort

echo "🧪 Testing Rails loading..."
ruby -e "require 'tsort'; puts 'tsort gem loaded successfully'"

echo "🚀 Testing Rails application..."
bin/rails --version

echo "✅ Fix completed! Try running 'bin/setup' again."
