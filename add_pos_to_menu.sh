#!/bin/bash

echo "📋 Adding POS & SHEIN to Admin Menu..."
echo "======================================"
echo ""

cd "/home/jason/AURELIO LIVING/spree_starter" || exit 1

# Update the menu initializer
cat > config/initializers/spree_admin_menu.rb << 'EOF'
# frozen_string_literal: true

# Customize Spree Admin Menu
# Remove unwanted menu items and add custom ones

Rails.application.config.after_initialize do
  # Configure admin menu
  Spree::Backend::Config.configure do |config|
    # Remove Vendors menu item from admin (Enterprise feature)
    config.menu_items.delete_if { |item| item.label == :vendors || item.label == 'Vendors' }
    
    # Add POS Barcode Scanner to menu
    config.menu_items << config.class::MenuItem.new(
      label: 'POS Scanner',
      icon: 'barcode',
      url: '/admin/barcode_scanner',
      match_path: '/barcode_scanner',
      position: 50
    )
    
    # Add SHEIN Imports to menu
    config.menu_items << config.class::MenuItem.new(
      label: 'SHEIN Imports',
      icon: 'download',
      url: '/admin/shein_imports',
      match_path: '/shein_imports',
      position: 51
    )
  end
end
EOF

echo "✅ Updated menu configuration"
echo ""
echo "📋 New menu items:"
echo "  - POS Scanner (barcode icon)"
echo "  - SHEIN Imports (download icon)"
echo ""

echo "📝 Staging changes..."
git add config/initializers/spree_admin_menu.rb
git add add_pos_to_menu.sh

echo "💾 Committing..."
git commit -m "feat: Add POS Scanner and SHEIN Imports to admin menu

Admin Menu Enhancements:
- Added POS Barcode Scanner to main admin menu
- Added SHEIN Product Import to main admin menu
- Kept Vendors removal (Enterprise feature)

Menu Items:
- POS Scanner: Quick access to barcode scanning interface
  Icon: barcode
  URL: /admin/barcode_scanner
  Position: After products section

- SHEIN Imports: Easy access to product import from SHEIN
  Icon: download
  URL: /admin/shein_imports
  Position: After POS Scanner

Benefits:
- No need to remember URLs
- One-click access to custom features
- Better user experience for staff
- Consistent with Spree admin design"

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
        echo "  - Refresh admin panel"
        echo "  - See 'POS Scanner' in menu"
        echo "  - See 'SHEIN Imports' in menu"
        echo "  - Both with icons!"
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
