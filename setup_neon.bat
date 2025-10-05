@echo off
echo Setting up environment variables for Rails application with Neon database...

REM Check if .env file exists
if not exist ".env" (
    echo ⚠️  .env file not found!
    echo Please create a .env file with your Neon database configuration:
    echo.
    echo DATABASE_URL=postgresql://username:password@your-neon-host:5432/your-database-name
    echo DATABASE_DIRECT_URL=postgresql://username:password@your-neon-host:5432/your-database-name
    echo SECRET_KEY_BASE=your_secret_key_base_here
    echo RAILS_ENV=development
    echo.
    echo You can get these values from your Neon dashboard.
    pause
    exit /b 1
)

REM Load environment variables from .env file
echo Loading environment variables from .env file...
for /f "usebackq tokens=1,2 delims==" %%a in (".env") do (
    if not "%%a"=="" if not "%%a:~0,1%"=="#" (
        set "%%a=%%b"
    )
)

REM Generate SECRET_KEY_BASE if not set
if "%SECRET_KEY_BASE%"=="" (
    echo Generating SECRET_KEY_BASE...
    for /f %%i in ('ruby -e "require 'securerandom'; puts SecureRandom.hex(64)"') do set SECRET_KEY_BASE=%%i
    echo Generated SECRET_KEY_BASE: %SECRET_KEY_BASE%
    echo Add this to your .env file: SECRET_KEY_BASE=%SECRET_KEY_BASE%
)

REM Set RAILS_ENV if not set
if "%RAILS_ENV%"=="" (
    set RAILS_ENV=development
)

echo Environment variables loaded:
echo DATABASE_URL: %DATABASE_URL%
echo DATABASE_DIRECT_URL: %DATABASE_DIRECT_URL%
echo SECRET_KEY_BASE: %SECRET_KEY_BASE:~0,20%...
echo RAILS_ENV: %RAILS_ENV%

echo.
echo Now you can run: bin/setup
echo Or run: setup_neon.bat && bin/setup
