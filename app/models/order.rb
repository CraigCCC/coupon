class Order < ApplicationRecord
  # relationships
  belongs_to :user
  has_many :order_items

  # validations
  validates :num, :serial_number, uniqueness: true

  # callback
  before_save :generate_random_num

  private

  def generate_random_num
    self.num = SecureRandom.hex(6)
    self.serial_number = SecureRandom.hex(10)
  end
end
