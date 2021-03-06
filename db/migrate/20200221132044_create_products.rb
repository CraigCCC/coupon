class CreateProducts < ActiveRecord::Migration[6.0]
  def change
    create_table :products do |t|
      t.string :title
      t.decimal :list_price
      t.integer :quantity
      t.belongs_to :product, null: false, foreign_key: true

      t.timestamps
    end
  end
end
