class AddColumnEnableToCoupons < ActiveRecord::Migration[6.0]
  def change
    add_column :coupons, :enable, :boolean, default: false
  end
end
