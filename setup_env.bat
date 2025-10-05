@echo off
echo Setting up environment variables for Rails application...

REM Generate a new secret key base using Ruby
echo Generating SECRET_KEY_BASE...
for /f %%i in ('ruby -e "require 'securerandom'; puts SecureRandom.hex(64)"') do set SECRET_KEY_BASE=%%i

REM Set environment variables
set RAILS_ENV=development

REM Set DATABASE_URL if not already set
if "%DATABASE_URL%"=="" (
    echo Setting default DATABASE_URL...
    set DATABASE_URL=postgresql://postgres:password@localhost:5432/spree_starter_development
)

echo Environment variables set:
echo SECRET_KEY_BASE: %SECRET_KEY_BASE%
echo DATABASE_URL: %DATABASE_URL%
echo RAILS_ENV: %RAILS_ENV%

echo.
echo Now you can run: bin/setup
echo Or run: setup_env.bat && bin/setup
