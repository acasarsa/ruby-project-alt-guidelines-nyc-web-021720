class AddTimestampsColumn < ActiveRecord::Migration[5.2]
  def change
    add_timestamps(:purchase_orders, null: true)  
  end
end
