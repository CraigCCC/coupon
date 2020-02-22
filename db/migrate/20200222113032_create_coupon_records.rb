class CreateCouponRecords < ActiveRecord::Migration[6.0]
  def change
    create_table :coupon_records do |t|
      t.references :coupon, null: false, foreign_key: true
      t.references :order, null: false, foreign_key: true

      t.timestamps
    end
  end
end
