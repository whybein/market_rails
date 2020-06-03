class Item < ApplicationRecord
  mount_uploader :image, ImageUploader

  belongs_to :user, optional: true
  belongs_to :category, optional: true

  has_many :line_items, dependent: :nullify
  # 상품이 삭제되도 주문 항목은 삭제되면 안 됨
  has_many :user_items, dependent: :destroy
  # 찜하기는 상품이 삭제되면 삭제되어도 됨(어차피 삭제된 상품 확인할 수 없음)

  has_many :comments, dependent: :destroy

  def self.generate_items
    %w(아이폰 안드로이드 아이패드 맥북 시계 애플워치 갤럭시기어).each do |title|
      category = Category.first
      Item.create(title: title, price: 2000000, category: category, image: Item.first.image, user: User.first)
    end
  end
end
