class AddTwoColumnUsefulAndBestDiscountToCouponRecords < ActiveRecord::Migration[6.0]
  def change
    add_column :coupons, :userful, :boolean, default: true
    add_column :coupons, :best_discount, :decimal
  end
end
