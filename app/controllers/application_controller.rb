class ApplicationController < ActionController::Base
  # Spree authentication helper compatibility
  helper_method :current_spree_user, :current_admin_user
  
  # For storefront
  def current_spree_user
    current_user if respond_to?(:current_user)
  end
  
  # For admin panel - Spree admin uses current_admin_user
  def current_admin_user
    current_user if respond_to?(:current_user)
  end
end
