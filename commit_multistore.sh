#!/bin/bash

echo "📦 Committing Multi-Store Setup..."
echo "=================================="
echo ""

cd "/home/jason/AURELIO LIVING/spree_starter" || exit 1

# Stage changes
git add config/initializers/spree.rb
git add lib/tasks/multistore.rake
git add MULTISTORE_SETUP.md
git add .env.example

# Commit
git commit -m "feat: Implement Multi-Store setup with subdomain routing

Multi-Store Configuration:
- Configured root_domain for myaurelio.com in spree.rb initializer
- Each new store gets automatic subdomain (e.g., outlet.myaurelio.com)
- Store codes can be customized in Admin Panel → Settings → Domains

New Features:
- Multi-store rake tasks for store management
- Create stores via CLI: bin/rails spree:multistore:create_store[\"Store Name\"]
- List all stores: bin/rails spree:multistore:list_stores
- Update URLs after domain change: bin/rails spree:multistore:update_store_urls

Documentation:
- Complete setup guide in MULTISTORE_SETUP.md
- Use cases: Multi-country, B2B/B2C, Outlet stores
- DNS configuration for production
- Local development with lvh.me

Environment Variables:
- SPREE_ROOT_DOMAIN=myaurelio.com (production)
- SPREE_ROOT_DOMAIN=lvh.me (development)

References:
- https://spreecommerce.org/docs/developer/multi-store/setup"

echo ""
echo "🚀 Pushing to GitHub..."
git push origin main

if [ $? -eq 0 ]; then
    echo ""
    echo "✅ Multi-Store setup pushed successfully!"
    echo ""
    echo "📋 Next Steps:"
    echo "  1. Update .env file with SPREE_ROOT_DOMAIN=myaurelio.com"
    echo "  2. Configure DNS wildcard: *.myaurelio.com"
    echo "  3. Create new stores in Admin Panel"
    echo "  4. Test subdomain routing"
else
    echo ""
    echo "❌ Push failed!"
fi

echo ""
echo "Done! 🎉"
