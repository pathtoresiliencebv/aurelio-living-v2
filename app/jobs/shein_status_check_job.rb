# frozen_string_literal: true

class SheinStatusCheckJob < ApplicationJob
  queue_as :default
  
  retry_on StandardError, wait: 5.minutes, attempts: 5
  
  def perform(shein_import_id)
    shein_import = Spree::SheinImport.find(shein_import_id)
    
    return unless shein_import.scraping?
    
    service = Spree::SheinImportService.new(
      api_token: shein_import.api_token || ENV['APIFY_API_TOKEN']
    )
    
    # Check Apify run status
    result = service.check_run_status(shein_import.apify_run_id)
    
    case result[:status]
    when 'SUCCEEDED'
      # Fetch scraped data
      data_result = service.get_scraped_products(result[:dataset_id])
      
      if data_result[:success]
        shein_import.update!(apify_dataset_id: result[:dataset_id])
        shein_import.mark_as_scraped!(data_result[:products])
        
        # Auto-process if configured
        if shein_import.auto_publish
          SheinProcessJob.perform_later(shein_import_id)
        end
      else
        shein_import.mark_as_failed!(data_result[:error])
      end
      
    when 'FAILED', 'ABORTED', 'TIMED-OUT'
      shein_import.mark_as_failed!("Apify run #{result[:status]}")
      
    when 'RUNNING'
      # Still running, check again in 30 seconds
      SheinStatusCheckJob.set(wait: 30.seconds).perform_later(shein_import_id)
    end
  rescue => e
    shein_import.mark_as_failed!(e.message) if shein_import
    raise e
  end
end
