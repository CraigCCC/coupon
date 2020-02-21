class ChangeColumnToProducts < ActiveRecord::Migration[6.0]
  def change
    rename_column :products, :product_id, :store_id
  end
end
