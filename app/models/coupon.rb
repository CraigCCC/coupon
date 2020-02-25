class Coupon < ApplicationRecord
  # relationships
  belongs_to :store
  belongs_to :product, optional: true
  has_many :coupon_records
  has_many :orders, through: :coupon_records

  # enums
  enum condition_type: [:full_number, :full_amount]
  enum discount_type: [:dis_amount, :dis_percent, :free_shipping, :dis_given_product]
  enum total_redemption_type: [:total_default, :total_rede_amount, :total_rede_num]
  enum people_redemption_type: [:people_default, :people_rede_amount, :people_rede_num]

  # scopes

  # class methods
  def self.available
    available_time.where(with_enable: true)
  end

  def self.available_time
    now = DateTime.now.to_date
    where('(effective_start_date <= ? AND effective_end_date >= ?) OR ( effective_start_date IS NULL AND effective_end_date IS NULL)', now, now)
  end
end
