class Coupon < ApplicationRecord
  # relationships
  belongs_to :store
  belongs_to :product, optional: true
  has_many :coupon_records
  has_many :orders, through: :coupon_records

  # enums
  enum condition_type: [:full_number, :full_amount]
  enum discount_type: [:dis_amount, :dis_percent, :free_shipping]
  enum total_redemption_type: [:total_default, :total_rede_amount, :total_rede_num]
  enum people_redemption_type: [:people_default, :people_rede_amount, :people_rede_num]
  enum effective_date_type: [:date_default, :date_range, :month_reset]
end
