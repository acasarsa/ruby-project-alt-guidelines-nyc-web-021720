class CreatePurchaseOrders < ActiveRecord::Migration[5.2]
  def change
    create_table :purchase_orders do |t|
      t.integer :sku
      t.float :unit_price
      t.integer :quantity
      t.boolean :processed
      t.datetime :order_date
      t.integer :total_unit_price
      t.integer :vendor_id
      t.integer :product_id
    end 
  end
end
