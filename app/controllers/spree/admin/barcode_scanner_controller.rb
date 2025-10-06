# frozen_string_literal: true

module Spree
  module Admin
    class BarcodeScannerController < Spree::Admin::BaseController
      # GET /admin/barcode_scanner
      def index
        @recent_scans = Spree::Product.with_barcode.order(updated_at: :desc).limit(10)
      end
      
      # POST /admin/barcode_scanner/lookup
      def lookup
        barcode = params[:barcode]&.strip
        
        if barcode.blank?
          render json: { error: Spree.t(:barcode_required) }, status: :unprocessable_entity
          return
        end
        
        # Search in products first
        product = Spree::Product.find_by_barcode(barcode)
        
        # If not found, search in variants
        if product.nil?
          variant = Spree::Variant.find_by_barcode(barcode)
          product = variant&.product
        end
        
        if product
          render json: {
            success: true,
            product: {
              id: product.id,
              name: product.name,
              sku: product.sku,
              barcode: barcode,
              price: product.price,
              url: edit_admin_product_path(product),
              image_url: product.images.first&.url(:small),
              available: product.available?,
              stock: product.total_on_hand
            }
          }
        else
          render json: { 
            success: false, 
            error: Spree.t(:barcode_not_found, barcode: barcode) 
          }, status: :not_found
        end
      rescue => e
        render json: { error: e.message }, status: :internal_server_error
      end
      
      # POST /admin/barcode_scanner/generate
      def generate
        product_id = params[:product_id]
        product = Spree::Product.find(product_id)
        
        product.generate_barcode
        product.save!
        
        render json: {
          success: true,
          barcode: product.barcode
        }
      rescue ActiveRecord::RecordNotFound
        render json: { error: Spree.t(:product_not_found) }, status: :not_found
      rescue => e
        render json: { error: e.message }, status: :internal_server_error
      end
    end
  end
end
