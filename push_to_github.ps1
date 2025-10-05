# PowerShell script to push changes to GitHub

Write-Host "🚀 Pushing changes to GitHub repository..." -ForegroundColor Green

# Navigate to project directory
Set-Location "\\wsl.localhost\Ubuntu\home\jason\AURELIO LIVING\spree_starter"

Write-Host "📋 Current directory: $(Get-Location)" -ForegroundColor Blue

# Check git status
Write-Host "📊 Git status:" -ForegroundColor Yellow
wsl -d Ubuntu -e bash -c "cd '/home/jason/AURELIO LIVING/spree_starter' && git status"

# Add all changes
Write-Host "📦 Adding all changes..." -ForegroundColor Yellow
wsl -d Ubuntu -e bash -c "cd '/home/jason/AURELIO LIVING/spree_starter' && git add ."

# Commit changes
Write-Host "💾 Committing changes..." -ForegroundColor Yellow
wsl -d Ubuntu -e bash -c "cd '/home/jason/AURELIO LIVING/spree_starter' && git commit -m 'Fix Gemfile.lock for Render deployment - Remove BUNDLED WITH section'"

# Push to GitHub
Write-Host "🌐 Pushing to GitHub..." -ForegroundColor Yellow
wsl -d Ubuntu -e bash -c "cd '/home/jason/AURELIO LIVING/spree_starter' && git push origin main"

Write-Host "✅ Successfully pushed to GitHub!" -ForegroundColor Green
Write-Host ""
Write-Host "🔄 Render will automatically redeploy..." -ForegroundColor Cyan
Write-Host "🌐 Check deployment at: https://aurelio-living-spree.onrender.com" -ForegroundColor Cyan
