class AddColumnsPeopleRedemptionTypeAndValueToCoupons < ActiveRecord::Migration[6.0]
  def change
    add_column :coupons, :people_redemption_type, :integer
    add_column :coupons, :people_redemption_value, :decimal
  end
end
