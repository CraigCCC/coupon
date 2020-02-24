class CartItem
  attr_reader :store_id, :product_id, :quantity

  def initialize(store_id, product_id, quantity = 1)
    @store_id = store_id
    @product_id = product_id
    @quantity = quantity
  end

  def increment!
    @quantity += 1
  end

  def product
    Product.find_by(id: @product_id, store_id: @store_id)
  end

  def price
    @quantity * product.list_price
  end

  def haved_coupon?(coupon)
    @product_id.include?(coupon.product_id) && @store_id.include?(coupon.store_id.to_s)
  end
end