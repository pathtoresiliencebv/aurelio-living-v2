@echo off
echo 🔧 Fixing tsort LoadError in Rails application...

REM Navigate to project directory
cd /d "\\wsl.localhost\Ubuntu\home\jason\AURELIO LIVING\spree_starter"

echo 📋 Current directory: %CD%

REM Check if we're in the right directory
if not exist "Gemfile" (
    echo ❌ Error: Gemfile not found. Are you in the correct directory?
    pause
    exit /b 1
)

echo 🔍 Checking current gem status...
wsl bash -c "cd '/home/jason/AURELIO LIVING/spree_starter' && bundle list | grep tsort" || echo "tsort not found in bundle list"

echo 🧹 Cleaning up gem cache and lock file...
wsl bash -c "cd '/home/jason/AURELIO LIVING/spree_starter' && rm -f Gemfile.lock"
wsl bash -c "cd '/home/jason/AURELIO LIVING/spree_starter' && bundle clean --force"

echo 📦 Reinstalling gems...
wsl bash -c "cd '/home/jason/AURELIO LIVING/spree_starter' && bundle install"

echo 🔍 Checking tsort gem specifically...
wsl bash -c "cd '/home/jason/AURELIO LIVING/spree_starter' && gem list tsort"

echo 🧪 Testing Rails loading...
wsl bash -c "cd '/home/jason/AURELIO LIVING/spree_starter' && ruby -e \"require 'tsort'; puts 'tsort gem loaded successfully'\""

echo 🚀 Testing Rails application...
wsl bash -c "cd '/home/jason/AURELIO LIVING/spree_starter' && bin/rails --version"

echo ✅ Fix completed! Try running 'bin/setup' again.
pause
