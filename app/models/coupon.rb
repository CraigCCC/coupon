class Coupon < ApplicationRecord
  # relationships
  belongs_to :store
  belongs_to :product, optional: true
  has_many :coupon_records
  has_many :orders, through: :coupon_records
end
