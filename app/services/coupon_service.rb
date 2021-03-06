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
      # 判斷折扣券的使用次數、金額限制
      # next unless is_redemption?(coupon)

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
      discount = @cart.total_price * (1 - coupon.discount_value / 10)
    when 'free_shipping'
      discount = @cart.total_shipping_fee
    when 'dis_given_product'
      discount = Product.find(coupon.given_product).list_price
    end

    discounts_array.push({
      coupon_id: coupon.id,
      discount: discount
    })# arr = [{ coupon_id: 1, discount: 200 }]
  end

  # (WIP)
  # def is_redemption?(coupon)
    # 總共
    # case coupon.total_redemption_type
    # when 'total_default'
    #   return true
    # when 'total_rede_amount'
    #   return coupon.total_redemption_value > CouponRecord.where(coupon_id: coupon.id).sum(:best_discount)
    # when 'total_rede_num'
    #   return coupon.total_redemption_value > coupon.coupon_records.where(need_count: true).count + 1
    # end


    # 每人
    # case coupon.people_redemption_type
    # when 'people_default'
    #   return true
    # when 'people_rede_amount'
    #   return 
    # when 'people_rede_num'
    # end
  # end
end