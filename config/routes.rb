Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/* (remember to link manifest in application.html.erb)
  # get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
  # get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker

  # Defines the root path route ("/")
  # root "posts#index"

  # This line mounts Spree's routes at the root of your application.
  # This means, any requests to URLs such as /products, will go to
  # Spree::ProductsController.
  # If you would like to change where this engine is mounted, simply change the
  # :at option to something different.
  #
  # We ask that you don't use the :as option here, as Spree relies on it being
  # the default of "spree".
  mount Spree::Core::Engine, at: '/'

  # Spree Admin Namespace - Barcode Scanner Extension
  namespace :admin do
    get 'barcode_scanner', to: 'barcode_scanner#index', as: :barcode_scanner
    post 'barcode_scanner/lookup', to: 'barcode_scanner#lookup'
    post 'barcode_scanner/generate', to: 'barcode_scanner#generate'
    
    # SHEIN Product Import Extension
    resources :shein_imports, only: [:index, :new, :create, :show] do
      collection do
        post :import
        get :status
      end
      member do
        post :process
      end
    end
  end
end