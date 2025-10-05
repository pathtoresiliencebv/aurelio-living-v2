#!/bin/bash

echo "🔍 Checking what's running on port 3000..."

# Check what's using port 3000
echo "📊 Processes on port 3000:"
lsof -i :3000 || echo "No process found on port 3000"

echo ""
echo "🛑 Killing processes on port 3000..."

# Kill processes on port 3000
fuser -k 3000/tcp 2>/dev/null || echo "No processes to kill on port 3000"

echo ""
echo "🧹 Killing any Rails/Puma processes..."

# Kill any Rails server processes
pkill -f "rails server" 2>/dev/null || echo "No Rails servers found"
pkill -f "puma" 2>/dev/null || echo "No Puma servers found"
pkill -f "bin/rails" 2>/dev/null || echo "No Rails processes found"

echo ""
echo "⏳ Waiting 3 seconds..."
sleep 3

echo ""
echo "🔍 Checking port 3000 again..."
lsof -i :3000 || echo "✅ Port 3000 is now free!"

echo ""
echo "🚀 Now you can start your Rails server:"
echo "   bin/rails server"
echo "   or"
echo "   bin/rails server -p 3001"
