#!/usr/bin/env bash
# Render build script for Spree Commerce

set -o errexit

echo "🔧 Starting Render build process..."

# Unfreeze bundle to allow updates
echo "📦 Unfreezing bundle..."
bundle config set frozen false

# Install dependencies
echo "📦 Installing dependencies..."
bundle install

# Precompile assets
echo "🎨 Precompiling assets..."
bin/rails assets:precompile

# Run database migrations
echo "🗄️ Running database migrations..."
bin/rails db:migrate

echo "✅ Build completed successfully!"