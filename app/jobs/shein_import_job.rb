# frozen_string_literal: true

class SheinImportJob < ApplicationJob
  queue_as :default
  
  retry_on StandardError, wait: 5.minutes, attempts: 3
  
  def perform(shein_import_id)
    shein_import = Spree::SheinImport.find(shein_import_id)
    
    service = Spree::SheinImportService.new(
      api_token: shein_import.api_token || ENV['APIFY_API_TOKEN'],
      store: shein_import.store
    )
    
    # Start Apify scraper
    result = service.start_scrape(
      search_term: shein_import.search_term,
      category_url: shein_import.category_url,
      max_items: shein_import.max_items
    )
    
    if result[:success]
      shein_import.mark_as_scraping!(result[:run_id])
      
      # Schedule status check job
      SheinStatusCheckJob.set(wait: 30.seconds).perform_later(shein_import_id)
    else
      shein_import.mark_as_failed!(result[:error])
    end
  rescue => e
    shein_import.mark_as_failed!(e.message) if shein_import
    raise e
  end
end
