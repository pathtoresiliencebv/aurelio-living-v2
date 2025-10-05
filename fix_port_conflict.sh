#!/bin/bash

echo "🔧 Fixing port conflict..."

# Navigate to project directory
cd "/home/jason/AURELIO LIVING/spree_starter"

echo "📋 Current directory: $(pwd)"

echo "🔍 Checking what's running on port 3000..."
lsof -i :3000 || echo "No process found on port 3000"

echo "🛑 Stopping any existing Rails servers..."
pkill -f "rails server" || echo "No Rails servers found"
pkill -f "puma" || echo "No Puma servers found"

echo "🧹 Cleaning up any leftover processes..."
sleep 2

echo "🚀 Starting Rails server on different port..."
bin/rails server -p 3001

echo "✅ Server should now be running on http://localhost:3001"
