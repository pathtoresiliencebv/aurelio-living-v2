# frozen_string_literal: true

module Spree
  module Themes
    # Aurelio Living Custom Theme
    # Premium e-commerce theme for home & living products
    # Fully customizable via Spree Admin Theme Editor
    class AurelioLiving < Spree::Theme
      def self.metadata
        {
          name: 'Aurelio Living',
          authors: ['Aurelio Living Team'],
          description: 'Premium e-commerce theme for home & living products',
          version: '1.0.0',
          license: 'Proprietary'
        }
      end

      # ============================================
      # COLORS - Main Brand Colors
      # ============================================
      
      # Primary colors
      preference :primary_color, :string, default: '#000000'
      preference :accent_color, :string, default: '#F0EFE9'
      preference :danger_color, :string, default: '#C73528'
      preference :neutral_color, :string, default: '#999999'
      preference :background_color, :string, default: '#FFFFFF'
      preference :text_color, :string, default: '#000000'
      preference :success_color, :string, default: '#00C773'

      # ============================================
      # BUTTONS - Primary
      # ============================================
      
      preference :button_background_color, :string, default: '#000000'
      preference :button_text_color, :string, default: '#ffffff'
      preference :button_hover_background_color, :string, default: '#333333'
      preference :button_hover_text_color, :string, default: '#ffffff'
      preference :button_border_color, :string, default: '#000000'
      preference :button_border_thickness, :integer, default: 1
      preference :button_border_opacity, :integer, default: 100
      preference :button_border_radius, :integer, default: 100
      preference :button_shadow_opacity, :integer, default: 0
      preference :button_shadow_horizontal_offset, :integer, default: 0
      preference :button_shadow_vertical_offset, :integer, default: 4
      preference :button_shadow_blur, :integer, default: 5

      # ============================================
      # BUTTONS - Secondary
      # ============================================
      
      preference :secondary_button_background_color, :string, default: '#FFFFFF'
      preference :secondary_button_text_color, :string, default: '#000000'
      preference :secondary_button_hover_background_color, :string, default: '#000000'
      preference :secondary_button_hover_text_color, :string, default: '#FFFFFF'

      # ============================================
      # INPUTS & FORMS
      # ============================================
      
      preference :input_text_color, :string, default: '#000000'
      preference :input_background_color, :string, default: '#ffffff'
      preference :input_border_color, :string, default: '#E9E7DC'
      preference :input_focus_border_color, :string, default: '#000000'
      preference :input_focus_background_color, :string, default: '#ffffff'
      preference :input_focus_text_color, :string, default: '#000000'
      preference :input_border_thickness, :integer, default: 1
      preference :input_border_opacity, :integer, default: 100
      preference :input_border_radius, :integer, default: 8
      preference :input_shadow_opacity, :integer, default: 0
      preference :input_shadow_horizontal_offset, :integer, default: 0
      preference :input_shadow_vertical_offset, :integer, default: 4
      preference :input_shadow_blur, :integer, default: 5

      # ============================================
      # BORDERS
      # ============================================
      
      preference :border_color, :string, default: '#E9E7DC'
      preference :sidebar_border_color, :string, default: '#E9E7DC'
      preference :border_width, :integer, default: 1
      preference :border_radius, :integer, default: 6
      preference :border_shadow_opacity, :integer, default: 0
      preference :border_shadow_horizontal_offset, :integer, default: 0
      preference :border_shadow_vertical_offset, :integer, default: 4
      preference :border_shadow_blur, :integer, default: 5

      # ============================================
      # CHECKOUT SIDEBAR
      # ============================================
      
      preference :checkout_sidebar_background_color, :string, default: '#f3f4f6'
      preference :checkout_divider_background_color, :string, default: '#E9E7DC'
      preference :checkout_sidebar_text_color, :string, default: '#000000'

      # ============================================
      # TYPOGRAPHY
      # ============================================
      
      # Custom font code (for Google Fonts or custom fonts)
      preference :custom_font_code, :string, default: nil
      
      # Body typography
      preference :font_family, :string, default: 'Inter'
      preference :font_size_scale, :integer, default: 100
      
      # Header typography
      preference :header_font_family, :string, default: 'Inter'
      preference :header_font_size_scale, :integer, default: 100
      preference :headings_uppercase, :boolean, default: false

      # ============================================
      # PRODUCT IMAGES
      # ============================================
      
      preference :product_listing_image_height, :integer, default: 300
      preference :product_listing_image_width, :integer, default: 300
      preference :product_listing_image_height_mobile, :integer, default: 190
      preference :product_listing_image_width_mobile, :integer, default: 190

      # ============================================
      # HERO SECTION (Custom)
      # ============================================
      
      preference :hero_background_color, :string, default: '#F0EFE9'
      preference :hero_text_color, :string, default: '#000000'
      preference :hero_min_height, :integer, default: 600
      preference :hero_overlay_opacity, :integer, default: 0

      # ============================================
      # BADGES (Custom)
      # ============================================
      
      preference :badge_border_radius, :integer, default: 4
      preference :sale_badge_background, :string, default: '#C73528'
      preference :sale_badge_text_color, :string, default: '#FFFFFF'
      preference :new_badge_background, :string, default: '#00C773'
      preference :new_badge_text_color, :string, default: '#FFFFFF'
      preference :in_stock_badge_background, :string, default: '#00C773'
      preference :in_stock_badge_text_color, :string, default: '#000000'

      # ============================================
      # NAVIGATION (Custom)
      # ============================================
      
      preference :navigation_background_color, :string, default: '#FFFFFF'
      preference :navigation_text_color, :string, default: '#000000'
      preference :navigation_hover_color, :string, default: '#C73528'
      preference :navigation_border_color, :string, default: '#E9E7DC'

      # ============================================
      # FOOTER (Custom)
      # ============================================
      
      preference :footer_background_color, :string, default: '#FFFFFF'
      preference :footer_text_color, :string, default: '#000000'
      preference :footer_border_color, :string, default: '#E9E7DC'
      preference :footer_link_color, :string, default: '#000000'
      preference :footer_link_hover_color, :string, default: '#C73528'
    end
  end
end

