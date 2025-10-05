#!/bin/bash

echo "🚀 Deploying Aurelio Living Spree Commerce to GitHub..."

# Navigate to project directory
cd "/home/jason/AURELIO LIVING/spree_starter"

echo "📋 Current directory: $(pwd)"

# Check if we're in a git repository
if [ ! -d ".git" ]; then
    echo "❌ Not a git repository. Initializing..."
    git init
    git remote add origin https://github.com/pathtoresiliencebv/aurelio-living.git
fi

# Check remote origin
echo "🔗 Remote origin:"
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

# Push to GitHub
echo "🌐 Pushing to GitHub..."
git push origin main

echo "✅ Successfully deployed to GitHub!"
echo ""
echo "🔄 Render will automatically redeploy..."
echo "🌐 Check deployment at: https://aurelio-living-spree.onrender.com"
echo "📊 Monitor deployment at: https://dashboard.render.com/web/srv-d3h64ue3jp1c73f9bpug"
