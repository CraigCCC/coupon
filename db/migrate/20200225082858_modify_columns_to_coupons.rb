class ModifyColumnsToCoupons < ActiveRecord::Migration[6.0]
  def change
    remove_column :coupons, :effective_date_type
    remove_column :coupons, :effective_quantity
    add_column :coupons, :month_reset, :boolean, default: false
  end
end
