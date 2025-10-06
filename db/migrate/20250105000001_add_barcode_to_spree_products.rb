class AddBarcodeToSpreeProducts < ActiveRecord::Migration[7.0]
  def change
    add_column :spree_products, :barcode, :string
    add_index :spree_products, :barcode, unique: true
    
    add_column :spree_variants, :barcode, :string
    add_index :spree_variants, :barcode, unique: true
  end
end
