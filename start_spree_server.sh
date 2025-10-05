#!/bin/bash

echo "🚀 Starting Spree server on WSL-friendly port..."

# Navigate to project directory
cd "/home/jason/AURELIO LIVING/spree_starter"

echo "📋 Current directory: $(pwd)"

# Set WSL-friendly port
export PORT=3001

echo "🧹 Cleaning up any leftover processes..."
pkill -f "rails server" 2>/dev/null || echo "No Rails servers found"
pkill -f "puma" 2>/dev/null || echo "No Puma servers found"

echo "⏳ Waiting 2 seconds..."
sleep 2

echo "🔍 Checking port 3001..."
lsof -i :3001 || echo "Port 3001 is free"

echo ""
echo "🚀 Starting Spree server on port 3001..."
echo "📱 Your Spree store will be available at: http://localhost:3001"
echo ""

# Start the server
bin/rails server
