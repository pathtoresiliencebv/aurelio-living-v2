#!/bin/bash

echo "🚀 Pushing sample data update to GitHub..."

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
git commit -m "Add Spree sample data loading to deployment"

# Push to GitHub
echo "🌐 Pushing to GitHub..."
git push origin main

echo "✅ Successfully pushed to GitHub!"
echo ""
echo "🔄 Render will automatically redeploy with sample data..."
echo "🌐 Check deployment at: https://aurelio-living-v2-upgraded.onrender.com"
