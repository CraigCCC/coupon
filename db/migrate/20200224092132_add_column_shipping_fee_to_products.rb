class AddColumnShippingFeeToProducts < ActiveRecord::Migration[6.0]
  def change
    add_column :products, :shipping_fee, :integer
  end
end
