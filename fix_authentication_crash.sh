#!/bin/bash

echo "🚨 FIXING AUTHENTICATION CRASH!!!"
echo "================================="
echo ""

cd "/home/jason/AURELIO LIVING/spree_starter" || exit 1

echo "🔍 Root Cause Found:"
echo "  - Devise creates: current_user"
echo "  - Spree expects: current_spree_user"
echo "  - Method missing = 500 error!"
echo ""
echo "✅ Solution:"
echo "  - Added current_spree_user helper in ApplicationController"
echo "  - It's an alias for current_user"
echo ""

echo "📝 Staging changes..."
git add app/controllers/application_controller.rb
git add fix_authentication_crash.sh
git add fix_authentication_crash.bat

echo ""
echo "💾 Committing..."
git commit -m "CRITICAL FIX: Add current_spree_user helper to fix 500 error

Root Cause:
- NoMethodError: undefined method current_user for Spree::HomeController
- lib/spree/authentication_helpers.rb calls current_spree_user
- Devise only creates current_user, not current_spree_user

Solution:
- Added current_spree_user helper in ApplicationController
- Returns current_user if available
- Fixes authentication integration between Devise and Spree

This resolves:
- 500 Internal Server Error on homepage
- NoMethodError in Spree::HomeController
- Authentication helper compatibility issues"

if [ $? -eq 0 ]; then
    echo ""
    echo "✅ Commit successful!"
    echo ""
    echo "🚀 Pushing to GitHub NOW!!!"
    git push origin main
    
    if [ $? -eq 0 ]; then
        echo ""
        echo "========================================"
        echo "✅ CRITICAL FIX DEPLOYED!"
        echo "========================================"
        echo ""
        echo "⏱️  Site should be working in ~2 minutes"
        echo ""
        echo "🌐 Check: https://aurelio-living-v2-upgraded.onrender.com"
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
