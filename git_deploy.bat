@echo off
echo 🚀 Deploying Aurelio Living Spree Commerce to GitHub...

echo 📋 Current directory: %CD%

echo 🔗 Setting up git remote...
wsl -d Ubuntu -e bash -c "cd '/home/jason/AURELIO LIVING/spree_starter' && git remote -v"

echo 📊 Git status:
wsl -d Ubuntu -e bash -c "cd '/home/jason/AURELIO LIVING/spree_starter' && git status"

echo 📦 Adding all changes...
wsl -d Ubuntu -e bash -c "cd '/home/jason/AURELIO LIVING/spree_starter' && git add ."

echo 💾 Committing changes...
wsl -d Ubuntu -e bash -c "cd '/home/jason/AURELIO LIVING/spree_starter' && git commit -m 'Fix Gemfile.lock for Render deployment - Remove BUNDLED WITH section and fix supabase gem issues'"

echo 🌐 Pushing to GitHub...
wsl -d Ubuntu -e bash -c "cd '/home/jason/AURELIO LIVING/spree_starter' && git push origin main"

echo ✅ Successfully deployed to GitHub!
echo.
echo 🔄 Render will automatically redeploy...
echo 🌐 Check deployment at: https://aurelio-living-spree.onrender.com
echo 📊 Monitor deployment at: https://dashboard.render.com/web/srv-d3h64ue3jp1c73f9bpug
pause
