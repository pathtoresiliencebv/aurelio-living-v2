#!/bin/bash

echo "🔍 Finding database URL..."

# Navigate to project directory
cd "/home/jason/AURELIO LIVING/spree_starter"

echo "📋 Current directory: $(pwd)"

# Check if .env file exists
if [ -f ".env" ]; then
    echo "📄 Found .env file:"
    cat .env | grep DATABASE_URL
else
    echo "❌ No .env file found"
fi

# Check environment variables
echo "🌍 Environment variables:"
echo "DATABASE_URL: $DATABASE_URL"

# Check if we can find database info in other files
echo "🔍 Searching for database configuration..."
grep -r "DATABASE_URL" . --include="*.md" --include="*.sh" --include="*.bat" | head -5
