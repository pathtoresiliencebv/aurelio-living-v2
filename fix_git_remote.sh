#!/bin/bash

echo "🔧 Fixing git remote to point to correct repository..."

# Navigate to project directory
cd "/home/jason/AURELIO LIVING/spree_starter"

echo "📋 Current directory: $(pwd)"

# Check current remote
echo "🔗 Current remote:"
git remote -v

# Change remote to correct repository
echo "🔄 Changing remote to correct repository..."
git remote set-url origin https://github.com/pathtoresiliencebv/aurelio-living.git

# Verify new remote
echo "✅ New remote:"
git remote -v

# Check git status
echo "📊 Git status:"
git status

# Add all changes
echo "📦 Adding all changes..."
git add .

# Commit changes
echo "💾 Committing changes..."
git commit -m "Fix Gemfile.lock for Render deployment - Remove BUNDLED WITH section and fix supabase gem issues"

# Push to correct repository
echo "🌐 Pushing to correct GitHub repository..."
git push origin main

echo "✅ Successfully pushed to correct repository!"
echo ""
echo "🔄 Render will automatically redeploy..."
echo "🌐 Check deployment at: https://aurelio-living-spree.onrender.com"
