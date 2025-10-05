@echo off
echo 🚀 Pushing changes to GitHub repository...

echo 📋 Current directory: %CD%

echo 📊 Git status:
wsl -d Ubuntu -e bash -c "cd '/home/jason/AURELIO LIVING/spree_starter' && git status"

echo 📦 Adding all changes...
wsl -d Ubuntu -e bash -c "cd '/home/jason/AURELIO LIVING/spree_starter' && git add ."

echo 💾 Committing changes...
wsl -d Ubuntu -e bash -c "cd '/home/jason/AURELIO LIVING/spree_starter' && git commit -m 'Fix Gemfile.lock for Render deployment - Remove BUNDLED WITH section'"

echo 🌐 Pushing to GitHub...
wsl -d Ubuntu -e bash -c "cd '/home/jason/AURELIO LIVING/spree_starter' && git push origin main"

echo ✅ Successfully pushed to GitHub!
echo.
echo 🔄 Render will automatically redeploy...
echo 🌐 Check deployment at: https://aurelio-living-spree.onrender.com
pause
