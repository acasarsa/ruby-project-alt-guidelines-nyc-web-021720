class UpdateTotalUnitPriceToFloat < ActiveRecord::Migration[5.2]
  def change
    change_column :purchase_orders, :total_unit_price, :float 
  end
end
