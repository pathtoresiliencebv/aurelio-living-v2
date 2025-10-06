# frozen_string_literal: true

module Spree
  module Themes
    # Helper methods for Aurelio Living Theme
    module AurelioLivingHelper
      # Render a badge for product status (Sale, New, In Stock)
      #
      # @param type [Symbol] Badge type (:sale, :new, :stock)
      # @param text [String] Badge text
      # @return [String] HTML for badge
      def aurelio_badge(type, text)
        css_class = case type
                    when :sale then 'badge badge-sale'
                    when :new then 'badge badge-new'
                    when :stock then 'badge badge-stock'
                    else 'badge'
                    end

        content_tag(:span, text, class: css_class)
      end

      # Render product card with Aurelio Living styling
      #
      # @param product [Spree::Product] Product instance
      # @param options [Hash] Additional options
      # @return [String] HTML for product card
      def aurelio_product_card(product, options = {})
        render partial: 'spree/shared/aurelio_product_card',
               locals: { product: product, options: options }
      end

      # Format price with savings display
      #
      # @param current_price [Money] Current price
      # @param original_price [Money] Original price (optional)
      # @return [String] HTML for price display
      def aurelio_price_display(current_price, original_price = nil)
        html = content_tag(:span, display_price(current_price), class: 'product-card-price')

        if original_price && original_price > current_price
          savings_amount = original_price - current_price
          savings_percentage = ((savings_amount / original_price) * 100).round

          old_price = content_tag(:span, display_price(original_price), 
                                  class: 'product-card-price-old')
          savings = content_tag(:span, "SAVE €#{savings_amount.to_i}", 
                               class: 'product-card-savings')
          
          html = old_price + html + savings
        end

        html.html_safe
      end

      # Get theme preference value
      #
      # @param preference_name [Symbol] Preference name
      # @return [String, Integer, Boolean] Preference value
      def theme_preference(preference_name)
        return nil unless current_theme.is_a?(Spree::Themes::AurelioLiving)

        current_theme.preferred(preference_name)
      end

      # Check if dark mode is enabled (for future implementation)
      #
      # @return [Boolean]
      def dark_mode_enabled?
        cookies[:aurelio_dark_mode] == 'true'
      end

      # Render hero section
      #
      # @param options [Hash] Hero section options
      # @return [String] HTML for hero section
      def aurelio_hero_section(options = {})
        render partial: 'spree/shared/aurelio_hero_section',
               locals: options
      end

      # Render features grid (USP section)
      #
      # @param features [Array<Hash>] Array of feature hashes
      # @return [String] HTML for features grid
      def aurelio_features_grid(features = [])
        default_features = [
          {
            icon: 'package',
            title: 'Gratis Verzending & Retour',
            description: 'Snelle levering wereldwijd'
          },
          {
            icon: 'rotate-ccw',
            title: 'Geld Terug Garantie',
            description: '30 dagen retourbeleid'
          },
          {
            icon: 'headphones',
            title: 'Online Ondersteuning 24/7',
            description: 'Deskundige hulp op elk moment'
          },
          {
            icon: 'tag',
            title: 'Regelmatige Aanbiedingen',
            description: 'Exclusieve ledenkorting'
          }
        ]

        features = default_features if features.empty?

        render partial: 'spree/shared/aurelio_features_grid',
               locals: { features: features }
      end
    end
  end
end

