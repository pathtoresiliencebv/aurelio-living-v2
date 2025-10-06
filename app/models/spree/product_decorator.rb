# frozen_string_literal: true

module Spree
  module ProductDecorator
    def self.prepended(base)
      base.validates :barcode, uniqueness: { allow_blank: true }, format: { 
        with: /\A[\d\-A-Z]+\z/, 
        message: Spree.t(:barcode_format_invalid),
        allow_blank: true 
      }
      
      base.scope :with_barcode, -> { where.not(barcode: nil) }
      base.scope :find_by_barcode, ->(code) { where(barcode: code).first }
    end

    # Generate a unique barcode if not present
    def generate_barcode
      return if barcode.present?
      
      loop do
        self.barcode = "AL#{Time.now.to_i}#{id || rand(1000..9999)}"
        break unless Spree::Product.exists?(barcode: barcode)
      end
    end
    
    # Validate barcode format (EAN-13, UPC, Code128, etc.)
    def validate_barcode_format
      return true if barcode.blank?
      
      # EAN-13 or UPC validation
      if barcode.length == 13 && barcode.match?(/\A\d+\z/)
        validate_ean13(barcode)
      else
        true # Allow other barcode formats
      end
    end
    
    private
    
    def validate_ean13(code)
      digits = code.chars.map(&:to_i)
      check_digit = digits.pop
      
      sum = digits.each_with_index.sum do |digit, index|
        index.even? ? digit : digit * 3
      end
      
      calculated_check = (10 - (sum % 10)) % 10
      calculated_check == check_digit
    end
  end

  Product.prepend(ProductDecorator)
end
