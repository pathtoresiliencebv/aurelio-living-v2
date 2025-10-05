#!/usr/bin/env ruby
# Final fix for Gemfile for Render deployment

puts "🔧 Final fix for Gemfile for Render deployment..."

# Read current Gemfile
gemfile_content = File.read('Gemfile')

# Check if supabase gem exists and remove it
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

# Update Gemfile.lock by removing frozen mode
puts "📦 Updating Gemfile.lock..."

# Remove frozen mode from Gemfile.lock
lockfile_content = File.read('Gemfile.lock')
if lockfile_content.include?('BUNDLED WITH')
  # Remove the BUNDLED WITH section to allow updates
  lockfile_content = lockfile_content.gsub(/BUNDLED WITH\s*\n\s*\d+\.\d+\.\d+\s*\n/, '')
  File.write('Gemfile.lock', lockfile_content)
  puts "✅ Removed BUNDLED WITH section from Gemfile.lock"
end

puts "✅ Gemfile fix completed!"
puts ""
puts "📝 Next steps:"
puts "   1. Commit and push changes to GitHub"
puts "   2. Redeploy on Render"
