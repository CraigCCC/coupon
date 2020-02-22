class CreateOrders < ActiveRecord::Migration[6.0]
  def change
    create_table :orders do |t|
      t.string :recipient
      t.string :tell
      t.string :address
      t.text :note
      t.string :status
      t.string :num
      t.decimal :shipping_fee
      t.string :serial_number
      t.belongs_to :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
