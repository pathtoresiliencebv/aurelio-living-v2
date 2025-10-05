#!/bin/bash

echo "🔍 Checking database connection status..."

# Navigate to project directory
cd "/home/jason/AURELIO LIVING/spree_starter"

echo "📋 Current directory: $(pwd)"

echo "🧪 Testing database connection..."
ruby -e "
begin
  require 'active_record'
  require 'pg'
  
  # Test if DATABASE_URL is set
  if ENV['DATABASE_URL'].nil? || ENV['DATABASE_URL'].empty?
    puts '❌ DATABASE_URL not set!'
    puts 'Please check your .env file'
    exit 1
  end
  
  puts '✅ DATABASE_URL is set: ' + ENV['DATABASE_URL'][0..50] + '...'
  
  # Test database connection
  ActiveRecord::Base.establish_connection(ENV['DATABASE_URL'])
  ActiveRecord::Base.connection.execute('SELECT 1')
  puts '✅ Database connection successful!'
  
rescue => e
  puts '❌ Database connection failed: ' + e.message
  puts 'Please check your Neon database configuration'
end
"

echo "📊 Checking database status..."
bin/rails db:version

echo "🔍 Checking pending migrations..."
bin/rails db:migrate:status

echo "✅ Database check completed!"
