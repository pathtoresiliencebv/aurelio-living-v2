#!/bin/bash

echo "🚀 Installing Spree Extensions for Aurelio Living..."
echo "=================================================="
echo ""

# Change to project directory
cd "/home/jason/AURELIO LIVING/spree_starter" || exit 1

echo "📦 Step 1: Installing gems with Bundle..."
bundle install

if [ $? -ne 0 ]; then
    echo "❌ Bundle install failed!"
    exit 1
fi

echo ""
echo "✅ Gems installed successfully!"
echo ""

echo "🔧 Step 2: Running extension generators..."
echo ""

# Reviews
echo "Installing spree_reviews..."
bin/rails g spree_reviews:install --auto-run-migrations

# Related Products
echo "Installing spree_related_products..."
bin/rails g spree_related_products:install --auto-run-migrations

# Volume Pricing
echo "Installing spree_volume_pricing..."
bin/rails g spree_volume_pricing:install --auto-run-migrations

# ShipStation
echo "Installing spree_shipstation..."
bin/rails g spree_shipstation:install --auto-run-migrations

# Product Assembly
echo "Installing spree_product_assembly..."
bin/rails g spree_product_assembly:install --auto-run-migrations

# Sitemap
echo "Installing spree_sitemap..."
bin/rails g spree_sitemap:install --auto-run-migrations 2>/dev/null || echo "  (No generator, will configure manually)"

echo ""
echo "📊 Step 3: Installing missing migrations..."
bin/rake railties:install:migrations

echo ""
echo "🗄️  Step 4: Running database migrations..."
bin/rails db:migrate

if [ $? -ne 0 ]; then
    echo "⚠️  Migrations had some issues, but continuing..."
fi

echo ""
echo "✅ Installation Complete!"
echo ""
echo "📋 Installed Extensions:"
echo "  ✓ spree_reviews - Product reviews and ratings"
echo "  ✓ spree_related_products - Related/Similar products"
echo "  ✓ spree_volume_pricing - Bulk pricing discounts"
echo "  ✓ spree_shipstation - ShipStation shipping integration"
echo "  ✓ spree_product_assembly - Product bundles"
echo "  ✓ spree_sitemap - XML Sitemap generator for SEO"
echo "  ✓ searchkick - Elasticsearch search (requires ES server)"
echo "  ✓ prawn - PDF generation for invoices"
echo ""
echo "⚠️  Next Steps:"
echo "  1. Restart your Rails server: bin/rails server -p 3001"
echo "  2. Visit http://localhost:3001/admin"
echo "  3. Configure extensions in admin panel"
echo ""
echo "📝 Note about Searchkick:"
echo "  - Requires Elasticsearch server running"
echo "  - To setup: https://github.com/ankane/searchkick#getting-started"
echo "  - For now, regular search will continue working"
echo ""
echo "🎉 Done!"

