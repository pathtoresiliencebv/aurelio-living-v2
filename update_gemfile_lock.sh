#!/bin/bash

echo "🔧 Updating Gemfile.lock for Render deployment..."

# Unfreeze bundle
bundle config set frozen false

# Update bundle
bundle update

# Re-freeze bundle
bundle config set frozen true

echo "✅ Gemfile.lock updated successfully!"
echo ""
echo "📝 Next steps:"
echo "   1. Commit and push changes to GitHub"
echo "   2. Redeploy on Render"
