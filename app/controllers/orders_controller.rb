class OrdersController < ApplicationController
  before_action :authenticate_user!
  before_action :load_object, only: [:show, :update]

  def new
    @order = get_cart
  end

  def update
    @order.paid!
    @order.update(paid_at: Time.now)
    redirect_to @order
  end

  def index
    @orders = current_user.orders.order(:paid_at).page(params[:page]).per(1)
  end

  private

  def load_object
    @order = Order.find(params[:id])
  end
end
