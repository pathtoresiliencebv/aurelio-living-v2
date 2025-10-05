#!/bin/bash

# Script to set up environment variables for Rails application with Neon database

echo "Setting up environment variables for Rails application with Neon database..."

# Check if .env file exists
if [ ! -f ".env" ]; then
    echo "⚠️  .env file not found!"
    echo "Please create a .env file with your Neon database configuration:"
    echo ""
    echo "DATABASE_URL=postgresql://username:password@your-neon-host:5432/your-database-name"
    echo "DATABASE_DIRECT_URL=postgresql://username:password@your-neon-host:5432/your-database-name"
    echo "SECRET_KEY_BASE=your_secret_key_base_here"
    echo "RAILS_ENV=development"
    echo ""
    echo "You can get these values from your Neon dashboard."
    exit 1
fi

# Load environment variables from .env file
echo "Loading environment variables from .env file..."
export $(grep -v '^#' .env | xargs)

# Generate SECRET_KEY_BASE if not set
if [ -z "$SECRET_KEY_BASE" ]; then
    echo "Generating SECRET_KEY_BASE..."
    export SECRET_KEY_BASE=$(ruby -e "require 'securerandom'; puts SecureRandom.hex(64)")
    echo "Generated SECRET_KEY_BASE: $SECRET_KEY_BASE"
    echo "Add this to your .env file: SECRET_KEY_BASE=$SECRET_KEY_BASE"
fi

# Set RAILS_ENV if not set
if [ -z "$RAILS_ENV" ]; then
    export RAILS_ENV=development
fi

echo "Environment variables loaded:"
echo "DATABASE_URL: $DATABASE_URL"
echo "DATABASE_DIRECT_URL: $DATABASE_DIRECT_URL"
echo "SECRET_KEY_BASE: ${SECRET_KEY_BASE:0:20}..."
echo "RAILS_ENV: $RAILS_ENV"

echo ""
echo "Now you can run: bin/setup"
echo "Or run: source setup_neon.sh && bin/setup"
