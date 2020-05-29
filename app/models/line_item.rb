class LineItem < ApplicationRecord
  belongs_to :order, optional: true
  belongs_to :item, optional: true

  # 상품이 삭제되어도 기존에 주문한 주문 항목은 남아있어야 해서 optional로 정의하고
  # item 쪽에 has_many 할 떄는 destroy 대신 nullify

  # line_item이 변경될 떄마다 주문의 총 가격 변경하기
  # line_item 본인을 변경할 때는 after_save 후 update 하지 말고(재귀함수처럼 계속)
  # before_save 하고 update 대 = 로 할당만 해서 save할 때 한 번에 저장되도록 처리하는 것이 좋음

  # line_item 본인이 아니라 order를 수정하는 것이므로  after_save 후 order.update를 해도 될듯

  # after_save :set_order_total

  def set_order_total
    puts "set_order_total"
    order.update(total: order.line_items.sum("amount * price"))
  end
end
