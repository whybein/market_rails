class OrdersController < ApplicationController
  before_action :authenticate_user!
  # 다른 사람도 주문 아이디만 알면 접근이 간으한 상태이므로 내 주문은 나만 볼수 있도 권한 체크
  before_action :load_object, :check_owner, only: [:edit, :show, :update]


  def new
    @order = get_cart
  end

  def edit

  end

  def update
    @order.paid!
    @order.update(paid_at: Time.now)
    redirect_to @order
  end

  def index
    @orders = current_user.orders.order(:paid_at).page(params[:page]).per(10)
  end

  private

  def load_object
    @order = Order.find(params[:id])
  end

  def check_owner
    redirect_to(root_path, notice: "권한이 없습니다") unless (@order.user == current_user)
  end
end
