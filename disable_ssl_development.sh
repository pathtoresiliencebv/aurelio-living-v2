#!/bin/bash

echo "🔧 Disabling SSL in development environment..."

# Navigate to project directory
cd "/home/jason/AURELIO LIVING/spree_starter"

echo "📋 Current directory: $(pwd)"

echo "🔧 Updating development environment to disable SSL..."

# Update development.rb to disable SSL
cat >> config/environments/development.rb << 'EOF'

# Disable SSL in development
config.force_ssl = false
config.assume_ssl = false
EOF

echo "✅ SSL disabled in development"
echo "🌐 Now use: http://localhost:3001 (not https://)"
echo "🔑 Admin: http://localhost:3001/admin"
