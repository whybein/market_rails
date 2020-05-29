class CreateOrders < ActiveRecord::Migration[6.0]
  def change
    create_table :orders do |t|
      t.references :user, null: false, foreign_key: true
      t.integer :status
      t.integer :total
      t.string :number
      t.string :zipcode
      t.string :address1
      t.string :address2
      t.datetime :paid_at
      t.datetime :canceled_at

      t.timestamps
    end
    add_index :orders, :status
    add_index :orders, :number

    # 데이터베이스 정렬 속도를 빠르게 하기 위해 index 추가
    # paid_at, canceled_at으로 정렬을 자주 할 것 같으면 index 추가
    add_index :orders, :paid_at
    add_index :orders, :canceled
  end
end
