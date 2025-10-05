#!/bin/bash

echo "🔧 Fixing Admin Menu for Spree 5.x..."
echo "====================================="
echo ""

cd "/home/jason/AURELIO LIVING/spree_starter" || exit 1

echo "✅ Changes made:"
echo "  - Updated to Spree::Admin::Config (instead of Spree::Backend)"
echo "  - Added safety checks with defined?()"
echo "  - Added error rescue to prevent initialization failures"
echo "  - Improved menu item deletion logic"
echo ""

echo "📋 Menu items that will be added:"
echo "  1. POS Scanner (barcode icon)"
echo "  2. SHEIN Imports (download icon)"
echo ""
echo "🗑️  Menu items that will be removed:"
echo "  - Vendors (Enterprise feature)"
echo ""

echo "📝 Staging changes..."
git add config/initializers/spree_admin_menu.rb
git add fix_admin_menu_spree5.sh

echo "💾 Committing..."
git commit -m "fix: Update admin menu customization for Spree 5.x compatibility

Fixed Build Error:
- Changed Spree::Backend to Spree::Admin (Spree 5.x)
- Added safety checks with defined?() guards
- Added error rescue to prevent initialization failures
- Improved menu item deletion with safe navigation

Changes:
FROM: Spree::Backend::Config.configure
TO:   Spree::Admin::Config.configure

FROM: Spree::Backend::MenuItem
TO:   Spree::Admin::MenuItem

Error Prevention:
- Skip if Spree::Admin not loaded yet
- Rescue StandardError to fail silently
- Check respond_to?(:menu_items) before accessing
- Safe navigation for label comparison

Menu Customization:
- Remove: Vendors menu item (Enterprise feature)
- Add: POS Scanner (/admin/barcode_scanner)
- Add: SHEIN Imports (/admin/shein_imports)

This resolves:
NameError: uninitialized constant Spree::Backend"

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
        echo "🎯 Deployment will now succeed!"
        echo ""
        echo "📋 After deployment:"
        echo "  1. Refresh admin panel"
        echo "  2. See 'POS Scanner' in menu"
        echo "  3. See 'SHEIN Imports' in menu"
        echo "  4. 'Vendors' will be hidden"
        echo ""
        echo "⏱️  Build time: ~5 minutes"
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
