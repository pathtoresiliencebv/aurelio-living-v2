#!/bin/bash

echo "🔧 Fixing Build Error..."
echo "======================="
echo ""

cd "/home/jason/AURELIO LIVING/spree_starter" || exit 1

echo "❌ Problem: Spree::Backend does not exist in Spree 5.x"
echo "✅ Solution: Remove custom admin menu initializer"
echo ""

# Remove the problematic initializer
if [ -f "config/initializers/spree_admin_menu.rb" ]; then
    echo "🗑️  Removing spree_admin_menu.rb..."
    rm config/initializers/spree_admin_menu.rb
    echo "✅ Removed!"
else
    echo "⚠️  File already removed or doesn't exist"
fi

echo ""
echo "📋 Note: POS and SHEIN are still accessible via URLs:"
echo "  - /admin/barcode_scanner"
echo "  - /admin/shein_imports"
echo ""
echo "💡 We'll add them to menu later via Spree 5 compatible method"
echo ""

echo "📝 Staging changes..."
git add -A

echo "💾 Committing..."
git commit -m "fix: Remove Spree::Backend menu customization causing build failure

Build Error Fix:
- Removed config/initializers/spree_admin_menu.rb
- Spree::Backend constant does not exist in Spree 5.x
- This was preventing assets:precompile from running

Error Details:
NameError: uninitialized constant Spree::Backend
  Spree::Backend::Config.configure do |config|
       ^^^^^^^^^

Solution:
- Removed custom menu initialization
- POS Scanner still accessible at: /admin/barcode_scanner
- SHEIN Imports still accessible at: /admin/shein_imports
- Will implement Spree 5 compatible menu later

Extensions still work via direct URLs:
- All features are functional
- Just not in sidebar menu yet
- Can be accessed by typing URL or bookmarking"

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
        echo "🎯 Build should succeed now!"
        echo ""
        echo "📋 After deployment:"
        echo "  1. Run: bin/rails db:migrate (for theme column)"
        echo "  2. Run: bin/rails aurelio:check_theme"
        echo "  3. Run: bin/rails aurelio:set_theme"
        echo ""
        echo "Access extensions via URLs:"
        echo "  - POS: /admin/barcode_scanner"
        echo "  - SHEIN: /admin/shein_imports"
    else
        echo ""
        echo "❌ Push failed!"
    fi
else
    echo ""
    echo "⚠️  Nothing to commit (file may already be removed)"
    echo "Checking current status..."
    git status
fi

echo ""
echo "Done! 🎉"
