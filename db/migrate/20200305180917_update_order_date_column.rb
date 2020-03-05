class UpdateOrderDateColumn < ActiveRecord::Migration[5.2]
  def change
    change_column :purchase_orders, :order_date, :date 
  end
end
