#!/bin/bash

echo "🗑️  Removing Spree Upgrade Popup & Vendors Menu..."
echo "=================================================="
echo ""

cd "/home/jason/AURELIO LIVING/spree_starter" || exit 1

echo "📋 Changes made:"
echo "  ✅ Enhanced CSS to hide all upgrade popups"
echo "  ✅ Added JavaScript to remove upgrade notices dynamically"
echo "  ✅ Created admin partial to inject hide script"
echo "  ✅ Created spree_admin_menu.rb to remove Vendors"
echo "  ✅ Updated spree.rb initializer"
echo ""

echo "📝 Staging changes..."
git add app/assets/stylesheets/spree/admin/custom.css
git add app/assets/javascripts/spree/backend/hide_upgrade_notices.js
git add app/views/spree/admin/shared/_hide_upgrade_script.html.erb
git add config/initializers/spree_admin_menu.rb
git add config/initializers/spree.rb
git add remove_upgrade_popup.sh

echo "💾 Committing..."
git commit -m "chore: Remove upgrade popup and Vendors menu from admin

UI Cleanup:
- Hide all 'Upgrade to Enterprise Edition' popups and notices
- Remove 'Community Edition' upgrade banners
- Hide bottom-left upgrade notification popup
- Remove 'Vendors' menu item from admin sidebar

Implementation:
- Enhanced CSS to hide upgrade-related elements
- Added JavaScript to dynamically remove notices (catches late-loading elements)
- Created admin partial with inline script for immediate execution
- MutationObserver watches for dynamically added upgrade notices
- Custom initializer to remove Vendors from admin menu

Files:
- app/assets/stylesheets/spree/admin/custom.css (enhanced)
- app/assets/javascripts/spree/backend/hide_upgrade_notices.js (new)
- app/views/spree/admin/shared/_hide_upgrade_script.html.erb (new)
- config/initializers/spree_admin_menu.rb (new)
- config/initializers/spree.rb (updated)

Result:
- Clean admin interface without upgrade nags
- Simplified menu without Vendors Enterprise feature
- Better branded experience for Aurelio Living"

if [ $? -eq 0 ]; then
    echo ""
    echo "✅ Commit successful!"
    echo ""
    echo "🚀 Pushing to GitHub..."
    git push origin main
    
    if [ $? -eq 0 ]; then
        echo ""
        echo "✅ Push successful!"
        echo ""
        echo "🎯 After deployment:"
        echo "  - Refresh admin panel"
        echo "  - Upgrade popup is GONE! ✅"
        echo "  - Vendors menu item is GONE! ✅"
        echo "  - Clean Aurelio Living interface! 🎨"
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
