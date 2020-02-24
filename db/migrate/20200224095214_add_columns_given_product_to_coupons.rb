class AddColumnsGivenProductToCoupons < ActiveRecord::Migration[6.0]
  def change
    add_column :coupons, :given_product, :string
  end
end
