class CreateInventoryEntries < ActiveRecord::Migration[5.2]
  def change
    create_table :inventory_entries do |t|
      t.integer :inventory
      t.float :price
      t.integer :product_id
      t.integer :vendor_id
    end
  end
end
