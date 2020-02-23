class CreateCoupons < ActiveRecord::Migration[6.0]
  def change
    create_table :coupons do |t|
      t.integer :condition_type
      t.decimal :condition_value
      t.integer :discount_type
      t.decimal :discount_value
      t.integer :total_redemption_type
      t.decimal :total_redemption_value
      t.integer :people_redemption_type
      t.decimal :people_redemption_value
      t.integer :effective_date_type
      t.date :effective_start_date
      t.date :effective_end_date
      t.integer :effective_quantity
      t.references :store, null: false, foreign_key: true
      t.string :product_id

      t.timestamps
    end
  end
end
