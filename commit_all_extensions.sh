#!/bin/bash

echo "📦 Committing All Aurelio Living Extensions..."
echo "=============================================="
echo ""

cd "/home/jason/AURELIO LIVING/spree_starter" || exit 1

echo "📋 Summary of Changes:"
echo "  ✅ Multi-Store setup with myaurelio.com"
echo "  ✅ POS Barcode Scanner extension"
echo "  ✅ SHEIN Product Import extension with Apify"
echo ""

# Stage all changes
echo "📝 Staging changes..."
git add .

# Commit
echo "💾 Committing..."
git commit -m "feat: Add Multi-Store, POS Barcode Scanner, and SHEIN Import extensions

Multi-Store Configuration:
- Configured root_domain for myaurelio.com
- Subdomain routing for each store (e.g., outlet.myaurelio.com)
- Rake tasks for store management
- Complete documentation in MULTISTORE_SETUP.md

Extension 1: POS Barcode Scanner
- Added barcode field to products and variants
- Barcode scanner interface in admin panel
- Real-time product lookup by barcode
- Audio feedback for scan success/error
- Auto-generate unique barcodes
- EAN-13 validation support
- Recent scans history
- API endpoints for lookup and generation

Files:
- db/migrate/20250105000001_add_barcode_to_spree_products.rb
- app/models/spree/product_decorator.rb
- app/models/spree/variant_decorator.rb
- app/controllers/spree/admin/barcode_scanner_controller.rb
- app/views/spree/admin/barcode_scanner/index.html.erb
- app/views/spree/admin/products/_barcode_field.html.erb

Extension 2: SHEIN Product Import with Apify
- Automated product scraping from SHEIN
- Apify API integration
- Background job processing with Sidekiq
- Import by search term or category URL
- Batch import up to 1000 products
- Auto-publish option
- Real-time status tracking
- Product variants (sizes, colors)
- Image import (up to 5 per product)
- SHEIN metadata preservation

Files:
- db/migrate/20250105000002_create_spree_shein_imports.rb
- app/models/spree/shein_import.rb
- app/services/spree/shein_import_service.rb
- app/controllers/spree/admin/shein_imports_controller.rb
- app/jobs/shein_import_job.rb
- app/jobs/shein_status_check_job.rb
- app/jobs/shein_process_job.rb
- app/views/spree/admin/shein_imports/[index|new|show].html.erb
- app/helpers/spree/admin/shein_imports_helper.rb

Configuration:
- Updated config/routes.rb for new endpoints
- Updated config/initializers/spree.rb for admin integration
- Added config/locales/en.yml for translations
- Updated .env.example with APIFY_API_TOKEN

Documentation:
- MULTISTORE_SETUP.md (Multi-store guide)
- EXTENSIONS_POS_SHEIN.md (Extensions documentation)
- Complete usage instructions
- API documentation
- Troubleshooting guide

Environment Variables Required:
- SPREE_ROOT_DOMAIN=myaurelio.com
- APIFY_API_TOKEN=your_apify_token

Admin Access:
- Multi-store: Admin → Multi-Store
- Barcode Scanner: /admin/barcode_scanner
- SHEIN Imports: /admin/shein_imports

Next Steps:
1. Run migrations: bin/rails db:migrate
2. Configure environment variables
3. Start Sidekiq: bundle exec sidekiq
4. Configure DNS for *.myaurelio.com
5. Test barcode scanner
6. Test SHEIN import

References:
- Spree Multi-Store: https://spreecommerce.org/docs/developer/multi-store/setup
- Apify Platform: https://apify.com"

if [ $? -eq 0 ]; then
    echo ""
    echo "✅ Commit successful!"
    echo ""
    echo "🚀 Pushing to GitHub..."
    git push origin main
    
    if [ $? -eq 0 ]; then
        echo ""
        echo "✅ Successfully pushed to GitHub!"
        echo ""
        echo "🎯 Deployment Info:"
        echo "  - Render will auto-deploy to: aurelio-living-v2-upgraded.onrender.com"
        echo "  - Run migrations: bin/rails db:migrate"
        echo "  - Restart server after deploy"
        echo ""
        echo "📋 TODO:"
        echo "  1. Configure APIFY_API_TOKEN in Render environment"
        echo "  2. Configure SPREE_ROOT_DOMAIN=myaurelio.com"
        echo "  3. Setup DNS wildcard: *.myaurelio.com"
        echo "  4. Start Sidekiq worker on Render"
        echo "  5. Test both extensions in production"
    else
        echo ""
        echo "❌ Push failed!"
    fi
else
    echo ""
    echo "❌ Commit failed!"
fi

echo ""
echo "Done! 🎉"
