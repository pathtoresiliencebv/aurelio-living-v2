#!/usr/bin/env ruby

puts "🔍 Checking Spree setup progress..."

# Check if we're in the right directory
unless File.exist?("Gemfile")
  puts "❌ Error: Not in Rails project directory"
  exit 1
end

puts "📋 Current directory: #{Dir.pwd}"

# Check Rails version
puts "🚀 Testing Rails loading..."
begin
  require_relative "config/application"
  puts "✅ Rails application loads successfully"
rescue => e
  puts "❌ Rails loading failed: #{e.message}"
  exit 1
end

# Check database schema
puts "🗄️ Checking database schema..."
if File.exist?("db/schema.rb")
  schema_content = File.read("db/schema.rb")
  if schema_content.include?("ActiveRecord::Schema")
    puts "✅ Database schema exists"
    
    # Count tables
    table_count = schema_content.scan(/create_table/).count
    puts "📊 Found #{table_count} database tables"
    
    # Check for Spree tables
    spree_tables = schema_content.scan(/create_table "spree_/).count
    puts "🛒 Found #{spree_tables} Spree tables"
  else
    puts "❌ Database schema is empty or corrupted"
  end
else
  puts "❌ Database schema file not found"
end

# Check migrations
puts "📦 Checking migrations..."
if Dir.exist?("db/migrate")
  migration_count = Dir.glob("db/migrate/*.rb").count
  puts "📊 Found #{migration_count} migration files"
  
  # Check for Spree migrations
  spree_migrations = Dir.glob("db/migrate/*spree*.rb").count
  puts "🛒 Found #{spree_migrations} Spree migrations"
else
  puts "❌ Migrations directory not found"
end

puts "✅ Setup progress check completed!"
puts ""
puts "💡 If the database setup is still running, it's normal for it to take 5-15 minutes"
puts "   especially with Neon database and Spree's complex schema."
