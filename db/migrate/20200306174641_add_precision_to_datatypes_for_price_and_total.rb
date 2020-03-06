class AddPrecisionToDatatypesForPriceAndTotal < ActiveRecord::Migration[5.2]
  def change
    change_column :purchase_orders, :total_unit_price, :decimal, :precision => 16, :scale => 2
    change_column :purchase_orders, :unit_price, :decimal, :precision => 16, :scale => 2
  end
end
