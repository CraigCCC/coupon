class EditColumnNameEnableToCopouns < ActiveRecord::Migration[6.0]
  def change
    rename_column :coupons, :enable, :with_enable
  end
end
