# frozen_string_literal: true

class SheinProcessJob < ApplicationJob
  queue_as :default
  
  retry_on StandardError, wait: 5.minutes, attempts: 3
  
  def perform(shein_import_id)
    shein_import = Spree::SheinImport.find(shein_import_id)
    
    unless shein_import.ready_to_process?
      raise "SheinImport ##{shein_import_id} is not ready to process (status: #{shein_import.status})"
    end
    
    shein_import.mark_as_processing!
    
    service = Spree::SheinImportService.new(
      api_token: shein_import.api_token || ENV['APIFY_API_TOKEN'],
      store: shein_import.store
    )
    
    # Import products into Spree
    result = service.import_products(
      shein_import.scraped_data,
      auto_publish: shein_import.auto_publish
    )
    
    if result[:success]
      shein_import.mark_as_completed!(result)
    else
      shein_import.mark_as_failed!("Import failed: #{result[:errors].map { |e| e[:error] }.join(', ')}")
    end
  rescue => e
    shein_import.mark_as_failed!(e.message) if shein_import
    raise e
  end
end
