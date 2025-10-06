#!/usr/bin/env bash
# Render build script for Spree Commerce

set -o errexit

echo "🔧 Starting Render build process..."

# Ensure we're using the correct Ruby version
if [ -f ".ruby-version" ]; then
  export RUBY_VERSION=$(cat .ruby-version)
  echo "📌 Using Ruby version: $RUBY_VERSION"
fi

# Install bundler if not present
if ! command -v bundle &> /dev/null; then
  echo "📦 Installing bundler..."
  gem install bundler --no-document
fi

# Configure bundler
echo "⚙️ Configuring bundler..."
bundle config set --local deployment false
bundle config set --local frozen false
bundle config set --local path vendor/bundle

# Install dependencies
echo "📦 Installing dependencies..."
bundle install --jobs=4 --retry=3

# Precompile assets
echo "🎨 Precompiling assets..."
RAILS_ENV=production bundle exec rails assets:precompile

echo "✅ Build completed successfully!"