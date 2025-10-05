@echo off
echo Fixing Admin Menu for Spree 5.x...
echo =====================================
echo.

cd /d "\\wsl.localhost\Ubuntu\home\jason\AURELIO LIVING\spree_starter"

echo Staging changes...
git add config/initializers/spree_admin_menu.rb
git add fix_admin_menu_spree5.sh
git add fix_admin_menu.bat

echo.
echo Committing...
git commit -m "fix: Update admin menu customization for Spree 5.x compatibility" -m "Fixed Build Error: Changed Spree::Backend to Spree::Admin (Spree 5.x)" -m "Added safety checks with defined?() guards" -m "Added error rescue to prevent initialization failures" -m "Menu: Remove Vendors, Add POS Scanner and SHEIN Imports"

echo.
echo Pushing to GitHub...
git push origin main

echo.
echo Done! Check Render deployment now!
pause
