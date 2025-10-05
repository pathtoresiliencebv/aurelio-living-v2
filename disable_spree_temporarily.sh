#!/bin/bash

echo "🔧 Temporarily disabling Spree gems to fix Rails loading..."

# Navigate to project directory
cd "/home/jason/AURELIO LIVING/spree_starter"

echo "📋 Current directory: $(pwd)"

# Backup original Gemfile
echo "💾 Backing up original Gemfile..."
cp Gemfile Gemfile.backup

# Comment out Spree gems temporarily
echo "🚫 Temporarily disabling Spree gems..."
sed -i 's/^gem "spree"/# gem "spree"/' Gemfile
sed -i 's/^gem "spree_emails"/# gem "spree_emails"/' Gemfile
sed -i 's/^gem "spree_sample"/# gem "spree_sample"/' Gemfile
sed -i 's/^gem "spree_admin"/# gem "spree_admin"/' Gemfile
sed -i 's/^gem "spree_storefront"/# gem "spree_storefront"/' Gemfile
sed -i 's/^gem "spree_i18n"/# gem "spree_i18n"/' Gemfile
sed -i 's/^gem "spree_stripe"/# gem "spree_stripe"/' Gemfile
sed -i 's/^gem "spree_google_analytics"/# gem "spree_google_analytics"/' Gemfile
sed -i 's/^gem "spree_klaviyo"/# gem "spree_klaviyo"/' Gemfile
sed -i 's/^gem "spree_paypal_checkout"/# gem "spree_paypal_checkout"/' Gemfile

echo "🧹 Cleaning up..."
rm -f Gemfile.lock
bundle clean --force

echo "📦 Reinstalling gems without Spree..."
bundle install

echo "🧪 Testing Rails loading without Spree..."
bin/rails --version

if [ $? -eq 0 ]; then
    echo "✅ Rails loads successfully without Spree!"
    echo "🚀 Try running: bin/setup"
    echo ""
    echo "📝 To re-enable Spree later, run:"
    echo "   cp Gemfile.backup Gemfile"
    echo "   bundle install"
else
    echo "❌ Rails still has issues. Restoring original Gemfile..."
    cp Gemfile.backup Gemfile
    bundle install
fi
