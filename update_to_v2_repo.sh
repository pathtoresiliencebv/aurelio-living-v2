#!/bin/bash

echo "🔄 Updating project to use new GitHub repository..."

# Navigate to project directory
cd "/home/jason/AURELIO LIVING/spree_starter"

echo "📋 Current directory: $(pwd)"

# Check current remote
echo "🔗 Current remote:"
git remote -v

# Change remote to new repository
echo "🔄 Changing remote to new repository..."
git remote set-url origin https://github.com/pathtoresiliencebv/aurelio-living-v2.git

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
git commit -m "Update project for Aurelio Living v2 - Fix Gemfile.lock for Render deployment"

# Push to new repository
echo "🌐 Pushing to new GitHub repository..."
git push origin main

echo "✅ Successfully pushed to new repository!"
echo ""
echo "🔄 Render will automatically redeploy..."
echo "🌐 Check deployment at: https://aurelio-living-spree.onrender.com"
echo "📊 Monitor deployment at: https://dashboard.render.com/web/srv-d3h64ue3jp1c73f9bpug"
