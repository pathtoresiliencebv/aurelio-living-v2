class AddThemeToSpreeStores < ActiveRecord::Migration[7.0]
  def change
    add_column :spree_stores, :theme, :string unless column_exists?(:spree_stores, :theme)
    add_index :spree_stores, :theme unless index_exists?(:spree_stores, :theme)
  end
end
