#!/bin/bash

echo "🔧 Temporarily disabling Sentry gems to fix Rails loading..."

# Navigate to project directory
cd "/home/jason/AURELIO LIVING/spree_starter"

echo "📋 Current directory: $(pwd)"

# Backup original Gemfile
echo "💾 Backing up original Gemfile..."
cp Gemfile Gemfile.backup

# Comment out Sentry gems temporarily
echo "🚫 Temporarily disabling Sentry gems..."
sed -i 's/^gem '\''sentry-ruby'\''/# gem '\''sentry-ruby'\''/' Gemfile
sed -i 's/^gem '\''sentry-rails'\''/# gem '\''sentry-rails'\''/' Gemfile
sed -i 's/^gem '\''sentry-sidekiq'\''/# gem '\''sentry-sidekiq'\''/' Gemfile

echo "🧹 Cleaning up..."
rm -f Gemfile.lock
bundle clean --force

echo "📦 Reinstalling gems without Sentry..."
bundle install

echo "🧪 Testing Rails loading without Sentry..."
bin/rails --version

if [ $? -eq 0 ]; then
    echo "✅ Rails loads successfully without Sentry!"
    echo "🚀 Try running: bin/setup"
    echo ""
    echo "📝 To re-enable Sentry later, run:"
    echo "   cp Gemfile.backup Gemfile"
    echo "   bundle install"
else
    echo "❌ Rails still has issues. Restoring original Gemfile..."
    cp Gemfile.backup Gemfile
    bundle install
fi
