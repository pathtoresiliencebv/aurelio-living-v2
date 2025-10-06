# frozen_string_literal: true

module Spree
  module Admin
    module SheinImportsHelper
      def status_badge_color(status)
        case status.to_s
        when 'pending'
          'secondary'
        when 'scraping'
          'info'
        when 'scraped'
          'primary'
        when 'processing'
          'warning'
        when 'completed'
          'success'
        when 'failed'
          'danger'
        else
          'secondary'
        end
      end
    end
  end
end
