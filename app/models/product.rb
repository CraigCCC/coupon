class Product < ApplicationRecord
  # relationships
  belongs_to :store
  has_many :order_items
end
