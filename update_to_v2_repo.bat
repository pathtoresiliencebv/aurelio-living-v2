@echo off
echo 🔄 Updating project to use new GitHub repository...

echo 📋 Current directory: %CD%

echo 🔗 Current remote:
wsl -d Ubuntu -e bash -c "cd '/home/jason/AURELIO LIVING/spree_starter' && git remote -v"

echo 🔄 Changing remote to new repository...
wsl -d Ubuntu -e bash -c "cd '/home/jason/AURELIO LIVING/spree_starter' && git remote set-url origin https://github.com/pathtoresiliencebv/aurelio-living-v2.git"

echo ✅ New remote:
wsl -d Ubuntu -e bash -c "cd '/home/jason/AURELIO LIVING/spree_starter' && git remote -v"

echo 📊 Git status:
wsl -d Ubuntu -e bash -c "cd '/home/jason/AURELIO LIVING/spree_starter' && git status"

echo 📦 Adding all changes...
wsl -d Ubuntu -e bash -c "cd '/home/jason/AURELIO LIVING/spree_starter' && git add ."

echo 💾 Committing changes...
wsl -d Ubuntu -e bash -c "cd '/home/jason/AURELIO LIVING/spree_starter' && git commit -m 'Update project for Aurelio Living v2 - Fix Gemfile.lock for Render deployment'"

echo 🌐 Pushing to new GitHub repository...
wsl -d Ubuntu -e bash -c "cd '/home/jason/AURELIO LIVING/spree_starter' && git push origin main"

echo ✅ Successfully pushed to new repository!
echo.
echo 🔄 Render will automatically redeploy...
echo 🌐 Check deployment at: https://aurelio-living-spree.onrender.com
echo 📊 Monitor deployment at: https://dashboard.render.com/web/srv-d3h64ue3jp1c73f9bpug
pause
