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
    discounts_array = []
    @store = Store.find(params[:store_id])
    @store.coupons.each do |coupon|
      # byebug
      if coupon.full_number? && current_cart.total_quantity >= coupon.condition_value
        case coupon.discount_type
        when 'dis_amount'
          discount = current_cart.total_price - coupon.discount_value
        when 'dis_percent'
          discount = current_cart.total_price * coupon.discount_value / 10
        when 'free_shipping'
        else
        end
        discounts_array.push({
          coupon_id: coupon.id,
          discount: discount
        })
      end
      if coupon.full_amount? && current_cart.total_price >= coupon.condition_value
        case coupon.discount_type
        when 'dis_amount'
          discount = current_cart.total_price - coupon.discount_value
        when 'dis_percent'
          discount = current_cart.total_price * coupon.discount_value / 10
        when 'free_shipping'
        else
        end
        discounts_array.push({
          coupon_id: coupon.id,
          discount: discount
        })
      end
      # byebug
      # @discounts_array
    end

    # @cart.total_price
    max = {discount: 0}
    discounts_array.each do |h|
      if max[:discount] < h[:discount]
        @discount_max = h
      end
    end

    @discount_max
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