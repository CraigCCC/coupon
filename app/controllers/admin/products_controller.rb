class Admin::ProductsController < ApplicationController
  before_action :find_product, only: [:show, :edit, :update, :destroy]

  layout 'backend'

  def index
    @store = Store.find(params[:store_id])
    @products = @store.products
  end

  def show
  end

  def new
    @product = Product.new
  end

  def create
    @product = Product.new(params_product)

    if @product.save
      redirect_to admin_store_products_path, notice: '新增成功'
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @product.update(params_product)
      redirect_to edit_admin_store_product_path(@product), notice: '更新成功'
    else
      render :edit
    end
  end

  def destroy
    @product.destroy
    redirect_to admin_store_products_path, notice: '刪除成功'
  end

  private

  def find_product
    @product = Product.find(params[:id])
  end

  def params_product
    params.require(:product).permit([:title, :list_price, :quantity, :store_id])
  end 
end
