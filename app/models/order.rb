class Order < ApplicationRecord
  include AASM

  # relationships
  belongs_to :user
  has_many :order_items
  has_many :coupon_records
  has_many :coupons, through: :coupon_records

  # callback
  before_save :generate_random_num

  # AASM
  aasm column: 'status', no_direct_assignment: true do
    state :pending, initial: true
    state :paid, :delivered, :cancelled

    event :pay do
      transitions from: :pending, to: :paid
      after do
        puts 'Send email'
        puts "#{self.serial_number}"
      end
    end

    event :deliver do
      transitions from: :paid, to: :delivered

    end

    event :cancel do
      transitions from: [:pending, :paid, :delivered], to: :cancelled
    end
  end

  private

  def generate_random_num
    loop do
      self.num = SecureRandom.hex(6)
      self.serial_number = SecureRandom.hex(10)
      break unless Order.where(num: self.num,serial_number: self.serial_number ).exists?
    end
  end
end
