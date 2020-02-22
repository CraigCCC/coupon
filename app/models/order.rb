class Order < ApplicationRecord
  # relationships
  belongs_to :user
  has_many :order_items
end
