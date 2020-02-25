class AddTwoColumnUsefulAndBestDiscountToCouponRecords < ActiveRecord::Migration[6.0]
  def change
    add_column :coupon_records, :userful, :boolean, default: true
    add_column :coupon_records, :best_discount, :decimal
  end
end
