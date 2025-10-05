#!/bin/bash

echo "🚀 Starting Spree server with HTTP (no SSL)..."

# Navigate to project directory
cd "/home/jason/AURELIO LIVING/spree_starter"

echo "📋 Current directory: $(pwd)"

# Set environment variables to disable SSL
export RAILS_ENV=development
export FORCE_SSL=false

echo "🧹 Cleaning up any leftover processes..."
pkill -f "rails server" 2>/dev/null || echo "No Rails servers found"
pkill -f "puma" 2>/dev/null || echo "No Puma servers found"

echo "⏳ Waiting 2 seconds..."
sleep 2

echo "🚀 Starting Rails server with HTTP..."
echo "🌐 Store: http://localhost:3001"
echo "🔑 Admin: http://localhost:3001/admin"
echo ""

# Start the server
bin/rails server
