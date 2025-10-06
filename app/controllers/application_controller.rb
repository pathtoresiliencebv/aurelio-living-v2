class ApplicationController < ActionController::Base
  # Spree authentication helper compatibility
  helper_method :current_spree_user, :current_admin_user
  
  # For storefront - maps to Devise's current_user (Spree::User)
  def current_spree_user
    current_user if respond_to?(:current_user)
  end
  
  # For admin panel - maps to Devise's current_admin_user (Spree::AdminUser)
  # Devise creates this automatically when you use devise_for :admin_users
  def current_admin_user
    # Devise automatically creates current_admin_user when devise_for :admin_users is defined
    super if defined?(super)
  end
end
