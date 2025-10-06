# frozen_string_literal: true

module Spree
  class SheinImport < Spree.base_class
    belongs_to :user, class_name: Spree.admin_user_class.to_s
    belongs_to :store, class_name: 'Spree::Store', optional: true
    
    # Status: pending, scraping, scraped, processing, completed, failed
    validates :status, presence: true, inclusion: { 
      in: %w[pending scraping scraped processing completed failed] 
    }
    
    validates :search_term, presence: true, if: -> { category_url.blank? }
    validates :category_url, presence: true, if: -> { search_term.blank? }
    validates :max_items, numericality: { greater_than: 0, less_than_or_equal_to: 1000 }
    
    serialize :scraped_data, JSON
    serialize :import_results, JSON
    serialize :errors, JSON
    
    scope :pending, -> { where(status: 'pending') }
    scope :completed, -> { where(status: 'completed') }
    scope :failed, -> { where(status: 'failed') }
    
    def processed?
      %w[processing completed failed].include?(status)
    end
    
    def scraping?
      status == 'scraping'
    end
    
    def ready_to_process?
      status == 'scraped' && scraped_data.present?
    end
    
    def mark_as_scraping!(run_id)
      update!(
        status: 'scraping',
        apify_run_id: run_id,
        started_at: Time.current
      )
    end
    
    def mark_as_scraped!(data)
      update!(
        status: 'scraped',
        scraped_data: data,
        scraped_at: Time.current
      )
    end
    
    def mark_as_processing!
      update!(status: 'processing')
    end
    
    def mark_as_completed!(results)
      update!(
        status: 'completed',
        import_results: results,
        completed_at: Time.current
      )
    end
    
    def mark_as_failed!(error_message)
      update!(
        status: 'failed',
        errors: { message: error_message, timestamp: Time.current },
        completed_at: Time.current
      )
    end
    
    def products_imported_count
      import_results&.dig('imported_count') || 0
    end
    
    def products_failed_count
      import_results&.dig('error_count') || 0
    end
  end
end
