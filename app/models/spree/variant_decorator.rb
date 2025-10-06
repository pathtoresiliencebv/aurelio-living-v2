# frozen_string_literal: true

module Spree
  module VariantDecorator
    def self.prepended(base)
      base.validates :barcode, uniqueness: { allow_blank: true }, format: { 
        with: /\A[\d\-A-Z]+\z/, 
        message: Spree.t(:barcode_format_invalid),
        allow_blank: true 
      }
      
      base.scope :with_barcode, -> { where.not(barcode: nil) }
      base.scope :find_by_barcode, ->(code) { where(barcode: code).first }
    end
    
    # Generate a unique barcode for variant
    def generate_barcode
      return if barcode.present?
      
      loop do
        self.barcode = "ALV#{Time.now.to_i}#{id || rand(1000..9999)}"
        break unless Spree::Variant.exists?(barcode: barcode)
      end
    end
  end

  Variant.prepend(VariantDecorator)
end
