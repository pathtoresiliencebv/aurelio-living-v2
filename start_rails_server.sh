#!/bin/bash

echo "🚀 Starting Rails server..."

# Navigate to project directory
cd "/home/jason/AURELIO LIVING/spree_starter"

echo "📋 Current directory: $(pwd)"

echo "🧹 Cleaning up any leftover processes..."
pkill -f "rails server" 2>/dev/null || echo "No Rails servers found"
pkill -f "puma" 2>/dev/null || echo "No Puma servers found"

echo "⏳ Waiting 2 seconds..."
sleep 2

echo "🔍 Checking port 3000..."
lsof -i :3000 || echo "Port 3000 is free"

echo ""
echo "🚀 Starting Rails server..."

# Try to start on port 3000 first
if bin/rails server 2>/dev/null; then
    echo "✅ Rails server started on port 3000"
else
    echo "⚠️ Port 3000 busy, trying port 3001..."
    bin/rails server -p 3001
fi
