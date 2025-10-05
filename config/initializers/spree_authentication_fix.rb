# frozen_string_literal: true

# Fix Spree authentication helper compatibility
# This runs AFTER Spree has loaded all its controllers

Rails.application.config.to_prepare do
  # Skip if already defined to avoid re-definition warnings
  next if Spree::BaseController.method_defined?(:current_spree_user)
  
  Spree::BaseController.class_eval do
    # Make current_spree_user available as a helper method in views
    helper_method :current_spree_user
    
    # Fix: Devise creates current_user, but Spree expects current_spree_user
    def current_spree_user
      # Try various methods to get the current user
      return current_user if respond_to?(:current_user, true) && current_user
      return try(:current_spree_user) if try(:current_spree_user)
      nil
    end
  end
  
  Rails.logger.info "✅ Spree authentication helper fixed: current_spree_user added to Spree::BaseController"
end
