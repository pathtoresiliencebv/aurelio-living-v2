class ApplicationController < ActionController::Base
  # Fix Spree authentication helper compatibility
  # Devise creates current_user, but Spree expects current_spree_user
  helper_method :current_spree_user
  
  def current_spree_user
    current_user if respond_to?(:current_user)
  end
end
