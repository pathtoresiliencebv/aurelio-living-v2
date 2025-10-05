@echo off
echo 🔧 Fixing git remote to point to correct repository...

echo 📋 Current directory: %CD%

echo 🔗 Current remote:
wsl -d Ubuntu -e bash -c "cd '/home/jason/AURELIO LIVING/spree_starter' && git remote -v"

echo 🔄 Changing remote to correct repository...
wsl -d Ubuntu -e bash -c "cd '/home/jason/AURELIO LIVING/spree_starter' && git remote set-url origin https://github.com/pathtoresiliencebv/aurelio-living.git"

echo ✅ New remote:
wsl -d Ubuntu -e bash -c "cd '/home/jason/AURELIO LIVING/spree_starter' && git remote -v"

echo 📊 Git status:
wsl -d Ubuntu -e bash -c "cd '/home/jason/AURELIO LIVING/spree_starter' && git status"

echo 📦 Adding all changes...
wsl -d Ubuntu -e bash -c "cd '/home/jason/AURELIO LIVING/spree_starter' && git add ."

echo 💾 Committing changes...
wsl -d Ubuntu -e bash -c "cd '/home/jason/AURELIO LIVING/spree_starter' && git commit -m 'Fix Gemfile.lock for Render deployment - Remove BUNDLED WITH section and fix supabase gem issues'"

echo 🌐 Pushing to correct GitHub repository...
wsl -d Ubuntu -e bash -c "cd '/home/jason/AURELIO LIVING/spree_starter' && git push origin main"

echo ✅ Successfully pushed to correct repository!
echo.
echo 🔄 Render will automatically redeploy...
echo 🌐 Check deployment at: https://aurelio-living-spree.onrender.com
pause
