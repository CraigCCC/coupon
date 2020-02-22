class OrdersController < ApplicationController
  def create
    @order = current_user.orders.build(order_params)

    current_cart.items.each do |item|
      @order.order_items.build(product: item.product,
                               quantity: item.quantity,
                               sell_price: item.product.list_price)
    end

    if @order.save
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
