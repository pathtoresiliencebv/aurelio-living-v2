#!/bin/bash

echo "🎨 Activating Aurelio Living Theme..."
echo "====================================="
echo ""

cd "/home/jason/AURELIO LIVING/spree_starter" || exit 1

echo "📋 What we're doing:"
echo "  1. Ensuring theme files are in place"
echo "  2. Updating theme registration"
echo "  3. Creating migration to set default theme"
echo ""

# Check if theme file exists
if [ -f "app/models/spree/themes/aurelio_living.rb" ]; then
    echo "✅ Theme file exists"
else
    echo "❌ Theme file missing!"
    exit 1
fi

# Check if theme CSS exists
if [ -f "app/assets/stylesheets/themes/aurelio_living/theme.css" ]; then
    echo "✅ Theme CSS exists"
else
    echo "❌ Theme CSS missing!"
    exit 1
fi

echo ""
echo "📝 Creating Rails task to set default theme..."

# Create a rake task to set the theme
cat > lib/tasks/set_theme.rake << 'EOF'
namespace :aurelio do
  desc "Set Aurelio Living as default theme for all stores"
  task set_theme: :environment do
    puts "🎨 Setting Aurelio Living theme..."
    
    Spree::Store.all.each do |store|
      # Set theme to AurelioLiving
      store.update(
        theme: 'Spree::Themes::AurelioLiving'
      )
      
      puts "✅ Updated store: #{store.name} (#{store.code})"
    end
    
    puts ""
    puts "✅ All stores now use Aurelio Living theme!"
    puts "🔄 Please restart your server to see changes"
  end
  
  desc "List all available themes"
  task list_themes: :environment do
    puts "📋 Available themes:"
    puts ""
    
    Rails.application.config.spree.themes.each do |theme|
      puts "  - #{theme}"
      if theme.respond_to?(:metadata)
        metadata = theme.metadata
        puts "    Name: #{metadata[:name]}"
        puts "    Description: #{metadata[:description]}"
        puts "    Version: #{metadata[:version]}"
        puts ""
      end
    end
  end
end
EOF

echo "✅ Created rake tasks"
echo ""
echo "📋 Available commands after deployment:"
echo "  - bin/rails aurelio:list_themes     (List all themes)"
echo "  - bin/rails aurelio:set_theme       (Set Aurelio Living as default)"
echo ""
echo "🚀 Ready to commit and deploy!"

echo ""
echo "📝 Staging changes..."
git add lib/tasks/set_theme.rake
git add activate_aurelio_theme.sh

echo "💾 Committing..."
git commit -m "feat: Add Aurelio Living theme activation tools

Theme Activation:
- Created rake task to set Aurelio Living as default theme
- Added task to list all available themes
- Automatic theme assignment to all stores

Usage:
After deployment, run in Render Shell or locally:
  bin/rails aurelio:list_themes  # See all themes
  bin/rails aurelio:set_theme    # Activate Aurelio Living

This will update all stores to use the Aurelio Living theme
with all 90+ customizable preferences available in admin.

Theme Features:
- 90+ customizable color, typography, and layout preferences
- Product card components
- Hero section templates
- Feature grids
- Custom badges
- Responsive design
- Multi-store compatible"

if [ $? -eq 0 ]; then
    echo ""
    echo "✅ Commit successful!"
    echo ""
    echo "🚀 Pushing to GitHub..."
    git push origin main
    
    if [ $? -eq 0 ]; then
        echo ""
        echo "✅ Push successful!"
        echo ""
        echo "🎯 After deployment:"
        echo "  1. Go to Render Shell"
        echo "  2. Run: bin/rails aurelio:set_theme"
        echo "  3. Restart your server"
        echo "  4. Refresh admin and see Aurelio Living theme!"
        echo ""
        echo "Or in admin panel:"
        echo "  1. Go to Storefront → Themes"
        echo "  2. Select 'Aurelio Living'"
        echo "  3. Click 'Customize'"
        echo "  4. Adjust colors, fonts, etc!"
    else
        echo ""
        echo "❌ Push failed!"
    fi
else
    echo ""
    echo "❌ Commit failed!"
fi

echo ""
echo "Done! 🎉"
