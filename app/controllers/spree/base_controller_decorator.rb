# frozen_string_literal: true

# Decorator to add authentication helpers to Spree::BaseController
# This fixes the NoMethodError for current_user in all Spree controllers

module Spree
  module BaseControllerDecorator
    def self.prepended(base)
      base.helper_method :current_spree_user if base.respond_to?(:helper_method)
    end

    # Fix Spree authentication helper compatibility
    # Devise creates current_user, but Spree expects current_spree_user
    def current_spree_user
      current_user if respond_to?(:current_user)
    end
  end
end

# Apply decorator to Spree::BaseController
Spree::BaseController.prepend(Spree::BaseControllerDecorator)
