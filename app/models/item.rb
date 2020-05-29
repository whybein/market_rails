class Item < ApplicationRecord
  mount_uploader :image, ImageUploader

  belongs_to :user, optional: true
  belongs_to :category, optional: true

  def self.generate_items
    %w(아이폰 안드로이드 아이패드 맥북 시계 애플워치 갤럭시기어).each do |title|
      category = Category.first
      Item.create(title: title, price: 2000000, category: category, image: Item.first.image, user: User.first)
    end
  end
end
