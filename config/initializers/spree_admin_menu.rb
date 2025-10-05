# frozen_string_literal: true

# Customize Spree Admin Menu
# DISABLED: Spree 5.x does not support menu customization via initializers
# The menu system works differently in Spree 5.x

# Access extensions via direct URLs:
# - POS Scanner: /admin/barcode_scanner
# - SHEIN Imports: /admin/shein_imports

# For menu customization in Spree 5.x, we need to:
# 1. Override the admin navigation partial
# 2. Or use Deface gem to inject menu items
# 3. Or create a custom admin menu component

Rails.application.config.after_initialize do
  # Menu customization disabled to prevent server errors
  # Will be re-implemented using Spree 5.x compatible methods
  
  Rails.logger.info "Admin menu customization disabled (Spree 5.x compatibility)"
  Rails.logger.info "Access POS Scanner at: /admin/barcode_scanner"
  Rails.logger.info "Access SHEIN Imports at: /admin/shein_imports"
end
