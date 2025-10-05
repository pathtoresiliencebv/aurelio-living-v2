#!/usr/bin/env ruby
# Remove supabase gem from Gemfile

puts "🔧 Removing supabase gem from Gemfile..."

# Read Gemfile
gemfile_content = File.read('Gemfile')

# Check if supabase gem exists
if gemfile_content.include?('supabase')
  puts "❌ Found supabase gem in Gemfile, removing..."
  
  # Remove supabase gem line
  gemfile_content = gemfile_content.gsub(/gem\s+['"]supabase.*\n/, '')
  
  # Write updated Gemfile
  File.write('Gemfile', gemfile_content)
  puts "✅ Removed supabase gem from Gemfile"
else
  puts "✅ No supabase gem found in Gemfile"
end

puts "✅ Supabase gem removal completed!"
