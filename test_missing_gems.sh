#!/bin/bash

echo "🔍 Testing which gems are missing..."

# Navigate to project directory
cd "/home/jason/AURELIO LIVING/spree_starter"

echo "📋 Current directory: $(pwd)"

echo "🧪 Testing core Ruby gems..."
ruby -e "
missing_gems = []
gems_to_test = [
  'prettyprint',
  'pp', 
  'rexml',
  'stringio',
  'net/protocol',
  'net/http',
  'tsort',
  'activemerchant',
  'actionpack',
  'activesupport'
]

gems_to_test.each do |gem_name|
  begin
    require gem_name
    puts \"✅ #{gem_name} - OK\"
  rescue LoadError => e
    puts \"❌ #{gem_name} - MISSING: #{e.message}\"
    missing_gems << gem_name
  end
end

puts \"\\n📋 Missing gems: #{missing_gems.join(', ')}\"
puts \"\\n🔧 Installing missing gems...\"
missing_gems.each do |gem|
  puts \"Installing #{gem}...\"
  system(\"gem install #{gem}\")
end
"

echo "🧪 Testing Spree gem..."
ruby -e "
begin
  require 'spree'
  puts '✅ Spree gem loaded successfully'
rescue LoadError => e
  puts '❌ Spree LoadError: ' + e.message
end
"

echo "🚀 Testing Rails application..."
bin/rails --version

echo "✅ Test completed!"
