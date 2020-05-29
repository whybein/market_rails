class ItemsController < ApplicationController
  before_action :authenticate_user!, only: [:toggle] # 찜하기 로그인 해야 사용 가능
  before_action :load_object, only: [:show, :toggle, :edit] # 상품 상세와 찜하기는 @item을 먼저 불러옴
  def index
    # 내가 판매하는 상품
    if params[:type] == "selling"
      redirect_to root_path, notice: "로그인을 해야 합니다" unless current_user
      @items = current_user.items
    else
      @items = Item.all
      # 카테고리별 페이지
      @items = @items.where(category_id: params[:category_id]) if params[:category_id].present?
    end
    @items = @items.page(params[:page]).per(20)
  end

  def toggle
    if user_item = current_user.user_items.where(item: @item).first
      # 이미 찜한 상태라면 해제
      user_item.destroy
      flash[:notice] = "찜을 제거하였습니다."
    else
      # 찜한 상태가 아니면 찜하기
      current_user.user_items.where(item: @item).create
      flash[:notice] = "찜하였습니다."
    end
    redirect_to @item
  end

  def edit
    @order = get_cart
    line_item = @order.line_items.where(item: @item).first_or_create(price: @item.price)
    line_item.increment!(:amount)
    line_item.set_order_total
    redirect_to new_order_path, notice: "장바구니에 상품을 담았습니다."
  end

  def show

  end

  private

    def load_object
      @item = Item.find params[:id]
    end
end
