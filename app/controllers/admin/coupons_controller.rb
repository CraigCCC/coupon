class Admin::CouponsController < ApplicationController
  before_action :find_coupon, only: [:show, :destroy]

  layout 'backend'

  def index
    @store = Store.find(params[:store_id])
    @coupons = @store.coupons.order(created_at: 'asc')
  end

  def show
  end

  def new
    @coupon= Coupon.new
    @products = Store.find(params[:store_id]).products
  end

  def create
    @coupon = Coupon.new(params_coupon)

    if @coupon.save
      puts '-------------------'
      puts '-------------------'
      puts '-------------------'
      puts params
      puts '-------------------'
      puts '-------------------'
      puts '-------------------'
      redirect_to admin_store_coupons_path, notice: '新增 coupon 成功'
    else
      render :new
    end
  end

  def enable
    coupon = Coupon.find(params[:coupon_id])
    if coupon.enable
      coupon.update(enable: false)
    else
      coupon.update(enable: true)
    end
    redirect_to admin_store_coupons_path
  end

  def destroy
    @coupon.destroy
    redirect_to admin_store_coupons_path, notice: '刪除 coupon 成功'
  end

  private

  def find_coupon
    @coupon = Coupon.find(params[:id])
  end

  def params_coupon
    params.require(:coupon).permit([:name,
                                    :condition_type,
                                    :condition_value,
                                    :discount_type,
                                    :discount_value,
                                    :total_redemption_type,
                                    :total_redemption_value,
                                    :people_redemption_type,
                                    :people_redemption_value,
                                    :effective_date_type,
                                    :effective_start_date,
                                    :effective_end_date,
                                    :effective_quantity,
                                    :store_id,
                                    :product_id,
                                    :given_product])
  end
end
