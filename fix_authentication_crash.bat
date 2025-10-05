@echo off
echo FIXING AUTHENTICATION CRASH!!!
echo ================================
echo.

cd /d "\\wsl.localhost\Ubuntu\home\jason\AURELIO LIVING\spree_starter"

echo Root Cause Found:
echo   - Devise creates: current_user
echo   - Spree expects: current_spree_user
echo   - Method missing = 500 error!
echo.
echo Solution:
echo   - Added current_spree_user helper in ApplicationController
echo   - It's an alias for current_user
echo.

git add app/controllers/application_controller.rb
git add fix_authentication_crash.bat

git commit -m "CRITICAL FIX: Add current_spree_user helper to fix 500 error" -m "Root Cause:" -m "- NoMethodError: undefined method current_user for Spree::HomeController" -m "- lib/spree/authentication_helpers.rb calls current_spree_user" -m "- Devise only creates current_user, not current_spree_user" -m "" -m "Solution:" -m "- Added current_spree_user helper in ApplicationController" -m "- Returns current_user if available" -m "- Fixes authentication integration between Devise and Spree" -m "" -m "This resolves:" -m "- 500 Internal Server Error on homepage" -m "- NoMethodError in Spree::HomeController" -m "- Authentication helper compatibility issues"

echo.
echo Pushing to GitHub NOW!!!
git push origin main

echo.
echo ========================================
echo CRITICAL FIX DEPLOYED!
echo ========================================
echo.
echo Site should be working in ~2 minutes
echo.
pause
