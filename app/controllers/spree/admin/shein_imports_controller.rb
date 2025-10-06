# frozen_string_literal: true

module Spree
  module Admin
    class SheinImportsController < Spree::Admin::BaseController
      # GET /admin/shein_imports
      def index
        @recent_imports = SheinImport.order(created_at: :desc).limit(20)
      end
      
      # GET /admin/shein_imports/new
      def new
        @shein_import = SheinImport.new
      end
      
      # POST /admin/shein_imports
      def create
        @shein_import = SheinImport.new(shein_import_params)
        @shein_import.user = current_user
        @shein_import.status = 'pending'
        
        if @shein_import.save
          # Start Apify scraper in background
          SheinImportJob.perform_later(@shein_import.id)
          
          flash[:success] = Spree.t(:shein_import_started)
          redirect_to admin_shein_import_path(@shein_import)
        else
          flash.now[:error] = @shein_import.errors.full_messages.join(', ')
          render :new
        end
      end
      
      # GET /admin/shein_imports/:id
      def show
        @shein_import = SheinImport.find(params[:id])
      end
      
      # POST /admin/shein_imports/import
      def import
        api_token = params[:api_token] || ENV['APIFY_API_TOKEN']
        
        if api_token.blank?
          render json: { error: Spree.t(:apify_token_required) }, status: :unprocessable_entity
          return
        end
        
        service = Spree::SheinImportService.new(api_token: api_token)
        
        result = service.start_scrape(
          search_term: params[:search_term],
          category_url: params[:category_url],
          max_items: params[:max_items]&.to_i || 100
        )
        
        if result[:success]
          render json: {
            success: true,
            run_id: result[:run_id],
            message: Spree.t(:shein_scrape_started)
          }
        else
          render json: {
            success: false,
            error: result[:error]
          }, status: :unprocessable_entity
        end
      rescue => e
        render json: { error: e.message }, status: :internal_server_error
      end
      
      # GET /admin/shein_imports/status
      def status
        run_id = params[:run_id]
        api_token = params[:api_token] || ENV['APIFY_API_TOKEN']
        
        service = Spree::SheinImportService.new(api_token: api_token)
        result = service.check_run_status(run_id)
        
        render json: result
      rescue => e
        render json: { error: e.message }, status: :internal_server_error
      end
      
      # POST /admin/shein_imports/:id/process
      def process
        @shein_import = SheinImport.find(params[:id])
        
        if @shein_import.processed?
          flash[:error] = Spree.t(:shein_import_already_processed)
          redirect_to admin_shein_import_path(@shein_import)
          return
        end
        
        # Process import in background
        SheinProcessJob.perform_later(@shein_import.id)
        
        flash[:success] = Spree.t(:shein_import_processing)
        redirect_to admin_shein_import_path(@shein_import)
      end
      
      private
      
      def shein_import_params
        params.require(:shein_import).permit(
          :search_term,
          :category_url,
          :max_items,
          :auto_publish,
          :api_token
        )
      end
    end
  end
end
