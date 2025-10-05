@echo off
echo EMERGENCY FIX - Site is DOWN!
echo ================================
echo.

cd /d "\\wsl.localhost\Ubuntu\home\jason\AURELIO LIVING\spree_starter"

echo Disabling problematic admin menu customization...
echo.

git add config/initializers/spree_admin_menu.rb
git add emergency_fix.bat

echo Committing emergency fix...
git commit -m "EMERGENCY FIX: Disable admin menu customization causing server crash" -m "Issue: Internal Server Error after menu customization" -m "Root Cause: Spree 5.x does not support Spree::Admin::Config or Spree::Backend::Config" -m "Solution: Disabled menu customization completely" -m "Extensions still accessible via direct URLs:" -m "  - /admin/barcode_scanner (POS Scanner)" -m "  - /admin/shein_imports (SHEIN Imports)" -m "Next Steps: Implement menu via Deface gem or view overrides"

echo.
echo Pushing to GitHub NOW...
git push origin main

echo.
echo ========================================
echo EMERGENCY FIX DEPLOYED!
echo ========================================
echo.
echo Site should be back online in ~3 minutes
echo.
echo Access extensions at:
echo   - https://aurelio-living-v2-upgraded.onrender.com/admin/barcode_scanner
echo   - https://aurelio-living-v2-upgraded.onrender.com/admin/shein_imports
echo.
pause
