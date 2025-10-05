#!/bin/bash

echo "🚀 Deploying Aurelio Living to GitHub..."
echo "========================================"
echo ""

cd "/home/jason/AURELIO LIVING/spree_starter" || exit 1

# Check git status
echo "📊 Checking git status..."
git status

echo ""
echo "📝 Staging all changes..."
git add .

echo ""
echo "💾 Committing changes..."
git commit -m "feat: Add Aurelio Living custom theme and configurations

- Implemented custom Aurelio Living theme with 90+ customizable preferences
- Added theme components: header, footer, hero section, features grid, product cards
- Created theme helpers and view components
- Updated Gemfile with core dependencies
- Removed unstable Spree extensions
- Prepared for production deployment

Theme Features:
- Customizable colors, typography, buttons, borders
- Product cards with hover effects and badges
- Hero banner with pricing display
- USP/Features grid section
- Newsletter signup in footer
- Dark mode toggle UI (ready for implementation)
- Mobile responsive design
- SEO optimized structure

Ready for Render deployment."

if [ $? -ne 0 ]; then
    echo "⚠️  Nothing to commit or commit failed"
fi

echo ""
echo "🌐 Pushing to GitHub..."
git push origin main

if [ $? -eq 0 ]; then
    echo ""
    echo "✅ Successfully pushed to GitHub!"
    echo ""
    echo "📍 Repository URL: https://github.com/YOUR_USERNAME/spree_starter"
    echo ""
    echo "🎯 Next: Deploy to Render"
    echo "   Visit: https://dashboard.render.com"
    echo "   Or use Render CLI/API to deploy"
else
    echo ""
    echo "❌ Push failed. Check your git remote and credentials."
    echo ""
    echo "To fix:"
    echo "1. Check remote: git remote -v"
    echo "2. Set remote: git remote add origin YOUR_GITHUB_URL"
    echo "3. Try again: ./deploy_to_github.sh"
fi

echo ""
echo "Done! 🎉"
