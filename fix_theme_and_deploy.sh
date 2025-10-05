#!/bin/bash

echo "🔧 Fixing Theme Loading Issue..."
echo "================================"
echo ""

cd "/home/jason/AURELIO LIVING/spree_starter" || exit 1

echo "📝 Changes made:"
echo "  - Updated spree.rb initializer to explicitly load theme"
echo "  - Added safety check for theme class existence"
echo ""

echo "📦 Staging changes..."
git add config/initializers/spree.rb
git add fix_theme_and_deploy.sh

echo "💾 Committing..."
git commit -m "fix: Explicitly load Aurelio Living theme before registration

Fixed NameError on Render deployment by:
- Adding require_dependency for theme class before registration
- Added safety check with defined? to prevent errors
- Ensures theme is loaded during Rails initialization

This resolves the build error:
NameError: uninitialized constant Spree::Themes::AurelioLiving"

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
        echo "🎯 Render will now auto-deploy with the fix!"
        echo ""
        echo "⏱️  Deployment takes ~3-5 minutes"
        echo "📊 Monitor at: https://dashboard.render.com"
    else
        echo ""
        echo "❌ Push failed!"
    fi
else
    echo ""
    echo "❌ Commit failed - no changes to commit?"
fi

echo ""
echo "Done! 🎉"
