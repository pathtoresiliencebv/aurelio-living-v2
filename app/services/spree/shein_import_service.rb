# frozen_string_literal: true

require 'net/http'
require 'json'

module Spree
  class SheinImportService
    APIFY_API_URL = 'https://api.apify.com/v2'
    SHEIN_ACTOR_ID = 'curious_coder/shein-scraper' # Apify actor for SHEIN scraping
    
    attr_reader :api_token, :store
    
    def initialize(api_token: nil, store: nil)
      @api_token = api_token || ENV['APIFY_API_TOKEN']
      @store = store || Spree::Store.default
      
      raise ArgumentError, 'APIFY_API_TOKEN is required' if @api_token.blank?
    end
    
    # Start a new Apify actor run to scrape SHEIN products
    def start_scrape(search_term: nil, category_url: nil, max_items: 100)
      actor_input = {
        searchTerm: search_term,
        categoryUrl: category_url,
        maxItems: max_items,
        proxy: {
          useApifyProxy: true
        }
      }
      
      uri = URI("#{APIFY_API_URL}/acts/#{SHEIN_ACTOR_ID}/runs?token=#{@api_token}")
      http = Net::HTTP.new(uri.host, uri.port)
      http.use_ssl = true
      
      request = Net::HTTP::Post.new(uri)
      request['Content-Type'] = 'application/json'
      request.body = actor_input.to_json
      
      response = http.request(request)
      result = JSON.parse(response.body)
      
      if response.code.to_i == 201
        {
          success: true,
          run_id: result['data']['id'],
          status: result['data']['status']
        }
      else
        {
          success: false,
          error: result['error']['message']
        }
      end
    rescue => e
      {
        success: false,
        error: e.message
      }
    end
    
    # Check the status of an Apify run
    def check_run_status(run_id)
      uri = URI("#{APIFY_API_URL}/actor-runs/#{run_id}?token=#{@api_token}")
      http = Net::HTTP.new(uri.host, uri.port)
      http.use_ssl = true
      
      response = http.get(uri)
      result = JSON.parse(response.body)
      
      {
        success: true,
        status: result['data']['status'],
        finished_at: result['data']['finishedAt'],
        dataset_id: result['data']['defaultDatasetId']
      }
    rescue => e
      {
        success: false,
        error: e.message
      }
    end
    
    # Get scraped product data from Apify dataset
    def get_scraped_products(dataset_id)
      uri = URI("#{APIFY_API_URL}/datasets/#{dataset_id}/items?token=#{@api_token}&format=json")
      http = Net::HTTP.new(uri.host, uri.port)
      http.use_ssl = true
      
      response = http.get(uri)
      products = JSON.parse(response.body)
      
      {
        success: true,
        products: products
      }
    rescue => e
      {
        success: false,
        error: e.message
      }
    end
    
    # Import products from SHEIN data into Spree
    def import_products(shein_products, options = {})
      imported = []
      errors = []
      
      shein_products.each do |shein_product|
        begin
          product = create_or_update_product(shein_product, options)
          imported << product
        rescue => e
          errors << {
            name: shein_product['name'],
            error: e.message
          }
        end
      end
      
      {
        success: errors.empty?,
        imported_count: imported.count,
        error_count: errors.count,
        imported: imported,
        errors: errors
      }
    end
    
    private
    
    def create_or_update_product(shein_data, options = {})
      # Generate unique SKU from SHEIN product code
      sku = "SHEIN-#{shein_data['productCode'] || shein_data['id']}"
      
      product = Spree::Product.find_or_initialize_by(sku: sku)
      
      product.assign_attributes(
        name: shein_data['name'] || shein_data['title'],
        description: shein_data['description'] || shein_data['details'],
        price: parse_price(shein_data['price'] || shein_data['salePrice']),
        available_on: Time.current,
        status: options[:auto_publish] ? 'active' : 'draft'
      )
      
      # Add SHEIN metadata
      product.public_metadata ||= {}
      product.public_metadata['shein_product_code'] = shein_data['productCode'] || shein_data['id']
      product.public_metadata['shein_url'] = shein_data['url']
      product.public_metadata['shein_category'] = shein_data['category']
      product.public_metadata['shein_brand'] = shein_data['brand']
      product.public_metadata['imported_at'] = Time.current.iso8601
      
      # Save product
      product.save!
      
      # Import images
      import_product_images(product, shein_data['images']) if shein_data['images'].present?
      
      # Import variants (sizes, colors)
      import_product_variants(product, shein_data['variants']) if shein_data['variants'].present?
      
      product
    end
    
    def import_product_images(product, image_urls)
      return if image_urls.blank?
      
      image_urls.first(5).each_with_index do |url, index|
        next if url.blank?
        
        begin
          image = product.images.create!(
            attachment: URI.open(url),
            position: index + 1
          )
        rescue => e
          Rails.logger.error "Failed to import image #{url}: #{e.message}"
        end
      end
    end
    
    def import_product_variants(product, variants_data)
      return if variants_data.blank?
      
      variants_data.each do |variant_data|
        variant = product.variants.create!(
          sku: "#{product.sku}-#{variant_data['size']}-#{variant_data['color']}",
          price: parse_price(variant_data['price']),
          weight: variant_data['weight'],
          height: variant_data['height'],
          width: variant_data['width'],
          depth: variant_data['depth']
        )
        
        # Add variant options (size, color)
        if variant_data['size']
          option_type = Spree::OptionType.find_or_create_by!(name: 'size', presentation: 'Size')
          option_value = option_type.option_values.find_or_create_by!(name: variant_data['size'], presentation: variant_data['size'])
          variant.option_values << option_value
        end
        
        if variant_data['color']
          option_type = Spree::OptionType.find_or_create_by!(name: 'color', presentation: 'Color')
          option_value = option_type.option_values.find_or_create_by!(name: variant_data['color'], presentation: variant_data['color'])
          variant.option_values << option_value
        end
      end
    end
    
    def parse_price(price_string)
      return 0 if price_string.blank?
      
      # Remove currency symbols and convert to float
      price_string.to_s.gsub(/[^\d\.]/, '').to_f
    end
  end
end
