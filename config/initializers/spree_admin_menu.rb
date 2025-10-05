# frozen_string_literal: true

# Customize Spree Admin Menu (Spree 5.x compatible)
# Remove unwanted menu items and add custom ones

Rails.application.config.after_initialize do
  # Skip if Spree Admin is not loaded yet
  next unless defined?(Spree::Admin)
  
  # Spree 5.x uses Spree::Admin::Config instead of Spree::Backend::Config
  begin
    if defined?(Spree::Admin::Config)
      Spree::Admin::Config.configure do |config|
        # Remove Vendors menu item from admin (Enterprise feature)
        if config.respond_to?(:menu_items)
          config.menu_items.delete_if { |item| 
            item.label.to_s.downcase == 'vendors' rescue false
          }
          
          # Add POS Barcode Scanner to menu
          config.menu_items << Spree::Admin::MenuItem.new(
            label: 'POS Scanner',
            icon: 'barcode',
            url: '/admin/barcode_scanner',
            match_path: '/barcode_scanner'
          )
          
          # Add SHEIN Imports to menu
          config.menu_items << Spree::Admin::MenuItem.new(
            label: 'SHEIN Imports',
            icon: 'download',
            url: '/admin/shein_imports',
            match_path: '/shein_imports'
          )
        end
      end
    end
  rescue StandardError => e
    Rails.logger.warn "Could not configure admin menu: #{e.message}"
    # Fail silently to not break initialization
  end
end
