#!/usr/bin/env ruby
# Fix Gemfile for Render deployment

puts "🔧 Fixing Gemfile for Render deployment..."

# Read current Gemfile
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

# Update Gemfile.lock
puts "📦 Updating Gemfile.lock..."
system('bundle install')

puts "✅ Gemfile fix completed!"
puts ""
puts "📝 Next steps:"
puts "   1. Commit and push changes to GitHub"
puts "   2. Redeploy on Render"
