#!/bin/bash

echo "🚀 Pushing changes to GitHub repository..."

# Navigate to project directory
cd "/home/jason/AURELIO LIVING/spree_starter"

echo "📋 Current directory: $(pwd)"

# Check git status
echo "📊 Git status:"
git status

# Add all changes
echo "📦 Adding all changes..."
git add .

# Commit changes
echo "💾 Committing changes..."
git commit -m "Fix Gemfile.lock for Render deployment - Remove BUNDLED WITH section"

# Push to GitHub
echo "🌐 Pushing to GitHub..."
git push origin main

echo "✅ Successfully pushed to GitHub!"
echo ""
echo "🔄 Render will automatically redeploy..."
echo "🌐 Check deployment at: https://aurelio-living-spree.onrender.com"
