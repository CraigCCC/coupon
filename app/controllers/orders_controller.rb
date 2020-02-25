class OrdersController < ApplicationController
  def create
    @order = current_user.orders.build(order_params)

    current_cart.items.each do |item|
      @order.order_items.build(product: item.product,
                               quantity: item.quantity,
                               sell_price: item.product.list_price)
    end

    # 找出可用折扣券
    store_available_coupons = Store.find(params[:store_id]).coupons.available

    # 找出最優惠的折扣券
    discount_max = CouponService.new(current_cart, store_available_coupons).find_best_discount_coupon

    if params[:coupon_id] = discount_max[:coupon_id]
      coupon = Coupon.find(discount_max[:coupon_id])
      coupon.coupon_records.build(order: @order,
                                  useful: false,
                                  best_discount: discount_max[:coupon_id] )
    end

    if @order.save && coupon.save
      session[Cart::SessionKey] = nil
      redirect_to root_path, notice: '訂單已成立'
    else
      redirect_to root_path
    end
  end

  private

  def order_params
    params.require(:order).permit(:recipient, :tell, :address, :note, :status, :num, :shipping_fee, :serial_number)
  end
end
