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
