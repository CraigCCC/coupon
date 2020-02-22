class CouponRecord < ApplicationRecord
  # relationships
  belongs_to :coupon
  belongs_to :order
end
