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
  end

  def destroy
    session[Cart::SessionKey] = nil
    redirect_to stores_path, notice: "購物車已清空"
  end
end