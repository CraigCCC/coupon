class RenameColumnUserfulTocouponRecords < ActiveRecord::Migration[6.0]
  def change
    rename_column :coupon_records, :userful, :need_count
  end
end
