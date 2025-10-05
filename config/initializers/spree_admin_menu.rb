# frozen_string_literal: true

# Customize Spree Admin Menu
# Remove unwanted menu items and add custom ones

Rails.application.config.after_initialize do
  # Remove Vendors menu item from admin
  Spree::Backend::Config.configure do |config|
    # Find and remove the Vendors menu item
    config.menu_items.delete_if { |item| item.label == :vendors || item.label == 'Vendors' }
    
    # You can also add custom menu items here
    # Example:
    # config.menu_items << config.class::MenuItem.new(
    #   label: 'Custom Section',
    #   icon: 'fa-custom-icon',
    #   url: '/admin/custom',
    #   condition: -> { true }
    # )
  end
end
