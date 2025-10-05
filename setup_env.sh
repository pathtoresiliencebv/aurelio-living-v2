#!/bin/bash

# Script to set up environment variables for Rails application

echo "Setting up environment variables for Rails application..."

# Generate a new secret key base
echo "Generating SECRET_KEY_BASE..."
SECRET_KEY_BASE=$(ruby -e "require 'securerandom'; puts SecureRandom.hex(64)")

# Set environment variables for current session
export SECRET_KEY_BASE="$SECRET_KEY_BASE"
export RAILS_ENV=development

# Set DATABASE_URL if not already set
if [ -z "$DATABASE_URL" ]; then
    echo "Setting default DATABASE_URL..."
    export DATABASE_URL="postgresql://postgres:password@localhost:5432/spree_starter_development"
fi

echo "Environment variables set:"
echo "SECRET_KEY_BASE: $SECRET_KEY_BASE"
echo "DATABASE_URL: $DATABASE_URL"
echo "RAILS_ENV: $RAILS_ENV"

echo ""
echo "Now you can run: bin/setup"
echo "Or run: source setup_env.sh && bin/setup"
