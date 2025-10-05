#!/bin/bash

echo "🔄 Replacing Spree branding with Aurelio Living..."

# Navigate to project directory
cd "/home/jason/AURELIO LIVING/spree_starter"

echo "📋 Current directory: $(pwd)"

echo "🔍 Step 1: Finding all files with 'Spree' references..."
find . -type f \( -name "*.rb" -o -name "*.erb" -o -name "*.haml" -o -name "*.yml" -o -name "*.yaml" -o -name "*.md" -o -name "*.html" \) -not -path "./vendor/*" -not -path "./.git/*" -exec grep -l -i "spree" {} \; | head -20

echo ""
echo "🔍 Step 2: Finding upgrade messages..."
find . -type f \( -name "*.rb" -o -name "*.erb" -o -name "*.haml" -o -name "*.yml" -o -name "*.yaml" -o -name "*.md" -o -name "*.html" \) -not -path "./vendor/*" -not -path "./.git/*" -exec grep -l -i "upgrade.*enterprise" {} \;

echo ""
echo "🔍 Step 3: Finding Community Edition references..."
find . -type f \( -name "*.rb" -o -name "*.erb" -o -name "*.haml" -o -name "*.yml" -o -name "*.yaml" -o -name "*.md" -o -name "*.html" \) -not -path "./vendor/*" -not -path "./.git/*" -exec grep -l -i "community.*edition" {} \;

echo ""
echo "✅ Analysis completed!"
echo ""
echo "💡 Next steps:"
echo "1. Check the files found above"
echo "2. Replace 'Spree' with 'Aurelio Living' in relevant files"
echo "3. Remove upgrade messages from views and templates"
