class CouponService

  def initialize(cart, coupons)
    @cart = cart
    @store_enable_coupons = coupons
  end

  def find_best_discount_coupon
    # 存放每張折價券算好後的陣列
    discounts_array = []
    # 找到這間商店的可用 coupons
    @store_enable_coupons.each do |coupon|

      # case coupon.total_redemption_type
      # when 'total_default'
      # when 'total_rede_amount'
      #   if coupon.total_redmption_value > coupon.coupon_records.where()

      # when 'total_rede_num'
      #   if coupon.total_redmption_value > coupon.coupon_records.where(userful: false) + 1
      # end
      # next unless is_ok?

      # 特定商品 滿件數 折金額、趴數、免運費、贈送商品
      if coupon.product_id?
        @cart.items.each do |item|
          if item.haved_coupon?(coupon)
            if coupon.full_number? && item.quantity >= coupon.condition_value
              discount_type_to_caculate(coupon, discounts_array)
            end
          end
        end
      end

      # 訂單滿件數，折金額、趴數、免運費、贈送商品
      if coupon.full_number? && @cart.total_quantity >= coupon.condition_value
        discount_type_to_caculate(coupon, discounts_array)
      end

      # 訂單滿金額，折金額、趴數、免運費、贈送商品
      if coupon.full_amount? && @cart.total_price > coupon.condition_value
        discount_type_to_caculate(coupon, discounts_array)
      end
    end
    # 選取最優惠的一張折抵
    discount_max = discounts_array.max { |a, b| a[:discount] <=> b[:discount] }
    
    # 找出最優惠的折扣券
    # 找出後在訂單上打折，做出中間的表
  end

  private

  def discount_type_to_caculate(coupon, discounts_array)
    case coupon.discount_type
    when 'dis_amount'
      discount = coupon.discount_value
    when 'dis_percent'
      discount = current_cart.total_price * (1 - coupon.discount_value / 10)
    when 'free_shipping'
      discount = current_cart.total_shipping_fee
    when 'dis_given_product'
      discount = Product.find(coupon.given_product).list_price
    end
    discounts_array.push({
      coupon_id: coupon.id,
      discount: discount
    })
    # arr = [{
    #   coupon_id: 1,
    #   discount: 200
    # },{
    #   coupon_id: 2,
    #   discount: 500
    # },{
    #   coupon_id: 3,
    #   discount: 100
    # }]
  end
end