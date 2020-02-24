class CartsController < ApplicationController
  def add
    current_cart.add_item(params[:store_id], params[:id])
    session[Cart::SessionKey] = current_cart.serialize

    redirect_to store_path(params[:store_id]), notice: '已加入購物車'
  end

  def show
  end

  def checkout
    # @store = Store.find(params[:store_id])
    @order = Order.new

    current_cart
    # CouponService.new(current_cart, @store).calculate_money

    # Coupon Logic
    # 存放每張折價券算好後的陣列
    discounts_array = []
    # 找到這間商店的可用 coupons
    @store_enable_coupons = Store.find(params[:store_id]).coupons.available_coupon
    @store_enable_coupons.each do |coupon|

      # 特定商品 滿件數 折金額或趴數
      if coupon.product_id?
        current_cart.items.each do |item|
          if item.haved_coupon?(coupon)
            if coupon.full_number? && item.quantity >= coupon.condition_value
              case coupon.discount_type
              when 'dis_amount'
                discount = current_cart.total_price - coupon.discount_value
              when 'dis_percent'
                discount = current_cart.total_price * coupon.discount_value / 10
              when 'free_shipping'
                discount = current_cart.total_shipping_fee
              when 'dis_given_product'
                discount = Product.find(coupon.given_product).list_price
              end
              discounts_array.push({
                coupon_id: coupon.id,
                discount: discount
              })
            end
          end
        end
      end

      # 訂單滿件數，折金額或趴數免運費
      if coupon.full_number? && current_cart.total_quantity >= coupon.condition_value
        case coupon.discount_type
        when 'dis_amount'
          discount = current_cart.total_price - coupon.discount_value
        when 'dis_percent'
          discount = current_cart.total_price * coupon.discount_value / 10
        when 'free_shipping'
          discount = current_cart.total_shipping_fee
        when 'dis_given_product'
          discount = Product.find(coupon.given_product).list_price
        end
        discounts_array.push({
          coupon_id: coupon.id,
          discount: discount
        })
      end

      # 訂單滿金額，折金額、趴數、免運費、贈送商品
      if coupon.full_amount? && current_cart.total_price > coupon.condition_value
        case coupon.discount_type
        when 'dis_amount'
          discount = current_cart.total_price - coupon.discount_value
        when 'dis_percent'
          discount = current_cart.total_price * coupon.discount_value / 10
        when 'free_shipping'
          discount = current_cart.total_shipping_fee
        when 'dis_given_product'
          discount = Product.find(coupon.given_product).list_price
        end
        discounts_array.push({
          coupon_id: coupon.id,
          discount: discount
        })
      end

    end

    # 訂單滿Ｘ折Ｙ，選取最優惠的一張折抵
    max = {discount: 0}
    discounts_array.each do |h|
      if max[:discount] <= h[:discount]
        @discount_max = h
      end
    end

    @discount_max
    # 找出最優惠的折扣券
    # 找出後在訂單上打折，做出中間的表

  end

  def destroy
    session[Cart::SessionKey] = nil
    redirect_to stores_path, notice: "購物車已清空"
  end
end

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
# max = {discount: 0}

# arr.each do |h|
#   if max[:discount] < h[:discount]
#     max = h
#   end
# end

# max 