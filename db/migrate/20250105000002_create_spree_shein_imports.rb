class CreateSpreeSheinImports < ActiveRecord::Migration[7.0]
  def change
    create_table :spree_shein_imports do |t|
      t.references :user, null: false
      t.references :store
      
      t.string :search_term
      t.string :category_url
      t.integer :max_items, default: 100
      t.boolean :auto_publish, default: false
      
      t.string :status, null: false, default: 'pending'
      t.string :apify_run_id
      t.string :apify_dataset_id
      
      t.text :scraped_data
      t.text :import_results
      t.text :errors
      
      t.datetime :started_at
      t.datetime :scraped_at
      t.datetime :completed_at
      
      t.timestamps
    end
    
    add_index :spree_shein_imports, :status
    add_index :spree_shein_imports, :apify_run_id
    add_index :spree_shein_imports, :created_at
  end
end
