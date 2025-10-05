#!/bin/bash

echo "🔧 Fixing Theme System..."
echo "========================"
echo ""

cd "/home/jason/AURELIO LIVING/spree_starter" || exit 1

echo "📋 What we're doing:"
echo "  1. Add 'theme' column to spree_stores table"
echo "  2. Update rake task to set theme properly"
echo "  3. Deploy and run migration"
echo ""

echo "✅ Created migration: add_theme_to_spree_stores.rb"
echo ""

# Update the rake task to be more robust
cat > lib/tasks/set_theme.rake << 'EOF'
namespace :aurelio do
  desc "Set Aurelio Living as default theme for all stores"
  task set_theme: :environment do
    puts "🎨 Setting Aurelio Living theme..."
    puts ""
    
    # Check if theme column exists
    unless Spree::Store.column_names.include?('theme')
      puts "❌ ERROR: 'theme' column does not exist on spree_stores table"
      puts "Please run: bin/rails db:migrate"
      exit 1
    end
    
    # Set theme for all stores
    Spree::Store.all.each do |store|
      old_theme = store.theme
      store.update!(theme: 'Spree::Themes::AurelioLiving')
      
      puts "✅ Updated store: #{store.name}"
      puts "   Code: #{store.code}"
      puts "   Old theme: #{old_theme || 'none'}"
      puts "   New theme: Spree::Themes::AurelioLiving"
      puts ""
    end
    
    puts "🎉 All stores now use Aurelio Living theme!"
    puts ""
    puts "📋 Next steps:"
    puts "  1. Go to Admin Panel → Storefront → Themes"
    puts "  2. You should see 'Aurelio Living' as Live theme"
    puts "  3. Click 'Customize' to adjust colors, fonts, etc."
  end
  
  desc "List all available themes"
  task list_themes: :environment do
    puts "📋 Registered themes in Rails config:"
    puts ""
    
    if Rails.application.config.spree.themes.any?
      Rails.application.config.spree.themes.each_with_index do |theme, index|
        puts "#{index + 1}. #{theme}"
        
        if theme.respond_to?(:metadata)
          metadata = theme.metadata
          puts "   Name: #{metadata[:name]}"
          puts "   Description: #{metadata[:description]}"
          puts "   Version: #{metadata[:version]}"
          puts ""
        end
      end
    else
      puts "⚠️  No themes registered!"
      puts ""
      puts "Check config/initializers/spree.rb for:"
      puts "  Rails.application.config.spree.themes << Spree::Themes::AurelioLiving"
    end
    
    puts ""
    puts "📋 Current store themes:"
    puts ""
    
    if Spree::Store.column_names.include?('theme')
      Spree::Store.all.each do |store|
        puts "  - #{store.name} (#{store.code}): #{store.theme || 'none'}"
      end
    else
      puts "  ⚠️  'theme' column does not exist yet"
      puts "  Run: bin/rails db:migrate"
    end
  end
  
  desc "Check theme system status"
  task check_theme: :environment do
    puts "🔍 Theme System Status Check"
    puts "=" * 50
    puts ""
    
    # Check if theme column exists
    has_theme_column = Spree::Store.column_names.include?('theme')
    puts "1. Theme column in database: #{has_theme_column ? '✅' : '❌'}"
    
    # Check if themes are registered
    themes_count = Rails.application.config.spree.themes.count
    puts "2. Registered themes: #{themes_count > 0 ? "✅ (#{themes_count})" : '❌ (0)'}"
    
    # Check if Aurelio Living is registered
    aurelio_registered = Rails.application.config.spree.themes.any? { |t| t.to_s.include?('AurelioLiving') }
    puts "3. Aurelio Living registered: #{aurelio_registered ? '✅' : '❌'}"
    
    # Check theme files
    theme_file_exists = File.exist?(Rails.root.join('app/models/spree/themes/aurelio_living.rb'))
    puts "4. Theme file exists: #{theme_file_exists ? '✅' : '❌'}"
    
    theme_css_exists = File.exist?(Rails.root.join('app/assets/stylesheets/themes/aurelio_living/theme.css'))
    puts "5. Theme CSS exists: #{theme_css_exists ? '✅' : '❌'}"
    
    puts ""
    
    if has_theme_column && themes_count > 0 && aurelio_registered && theme_file_exists
      puts "🎉 Everything looks good!"
      puts "Run: bin/rails aurelio:set_theme"
    else
      puts "⚠️  Some issues found. Fix them first!"
      
      unless has_theme_column
        puts "   → Run: bin/rails db:migrate"
      end
      
      unless themes_count > 0 || aurelio_registered
        puts "   → Check config/initializers/spree.rb"
      end
      
      unless theme_file_exists
        puts "   → Theme file missing!"
      end
    end
  end
end
EOF

echo "✅ Updated rake tasks"
echo ""

echo "📝 Staging changes..."
git add db/migrate/20250105000003_add_theme_to_spree_stores.rb
git add lib/tasks/set_theme.rake
git add fix_theme_system.sh

echo "💾 Committing..."
git commit -m "fix: Add theme column to stores and improve theme system

Database Migration:
- Added 'theme' column to spree_stores table
- Added index for performance
- Safe migration with column_exists? check

Improved Rake Tasks:
- aurelio:check_theme - Comprehensive system check
- aurelio:set_theme - Sets theme with validation
- aurelio:list_themes - Shows registered themes and store themes

Error Fix:
- Resolved: undefined method 'theme=' for Spree::Store
- Added proper database support for theme system
- Added safety checks before attempting operations

After deployment:
1. Run: bin/rails db:migrate
2. Run: bin/rails aurelio:check_theme
3. Run: bin/rails aurelio:set_theme
4. Refresh admin panel and see Aurelio Living theme!"

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
        echo "🎯 After deployment, run in Render Shell:"
        echo "  1. bin/rails db:migrate"
        echo "  2. bin/rails aurelio:check_theme"
        echo "  3. bin/rails aurelio:set_theme"
        echo ""
        echo "Then refresh admin and see your theme!"
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
