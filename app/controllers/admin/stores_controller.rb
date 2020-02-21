class Admin::StoresController < ApplicationController
  before_action :find_store, only: [:show, :edit, :update, :destroy]

  layout 'backend'
  
  def index
    @stores = current_user.stores
  end

  def show
  end

  def new
    @store = Store.new
  end

  def create
    @store = Store.new(params_store)
    if @store.save
      redirect_to admin_stores_path, notice: '新增商店成功'
    else
      render :edit
    end
  end

  def edit
  end

  def update
    if @store.update(params_store)
      redirect_to edit_admin_store_path, notice: '編輯商店成功'
    else
      render :edit
    end
  end

  def destroy
    @store.destroy
    redirect_to admin_stores_path, notice: '刪除商店成功'
  end

  private

  def find_store
    @store = Store.find(params[:id])
  end

  def params_store
    params.require(:store).permit(:name,
                                  :note,
                                  :tel,
                                  :address,
                                  :user_id)
  end
end
