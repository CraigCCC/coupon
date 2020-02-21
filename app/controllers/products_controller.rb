class ProductsController < ApplicationController
  def index
    @store = Store.find(params[:store_id])
    @products = @store.product
  end

  def show
    @product = Product.find(params[:id])
  end
end
