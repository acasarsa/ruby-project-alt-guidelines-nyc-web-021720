def say_hello
    puts "Hi, Hello!"
end 

def create_vendor(vendor_name)
    Vendor.create(name: vendor_name)
end 

def all_vendor_names
    # return list of all vendor names
    Vendor.all.map do |v|
        v.name
    end 
end 

def update_vendor_name(old_name, new_name)
    # updates vendor name
    update_vendor = Vendor.find_by name: old_name
    update_vendor.name = new_name
    update_vendor.save
end 

def delete_vendor(vendor)
    #delete vendor by name
    vendor_to_delete = Vendor.find_by name: vendor
    puts "Vendor #{vendor} has been deleted."
    Vendor.delete(vendor_to_delete.id)
end 
# product_controller

def all_product_names
    Product.all.map do |p|
        p.name
    end
end

def create_product(product_name)
    Product.create(name: product_name)
end

def update_product(old_name, new_name)
    update_product = Product.find_by_name(old_name) # abstracted 
    update_product.name = new_name
    update_product.save
end


def delete_product(product)
    product_to_delete = Product.find_by_name(product)
    puts "#{product} has been deleted"
    Product.delete(product_to_delete)
end

# def find_product_by_name(product)
#     find_product = Product.find_by name: product
# end

# call on Product or Vendor and returns object # may need this for :disabled ? to make delete error if processed
def find_by_name(name)
    self.find_by name: name
end
# purchase_order methods

def all_processed_purchase_orders
    PurchaseOrder.all.select do |po|
        po.processed == true
    end
end

def all_pending_purchase_orders
    PurchaseOrder.all.select do |po|
        po.processed == false
    end
end

def create_purchase_order(product, vendor, quantity, unit_price, order_date=Date.today)
    po_product = Product.find_by name: product
    po_vendor = Vendor.find_by name: vendor

    PurchaseOrder.create(product_id: po_product.id, vendor_id: po_vendor.id, quantity: quantity, unit_price: unit_price, sku: sku, order_date: order_date, processed: false, total_unit_price: total(quantity, unit_price))
end


def total(quantity, unit_price)
    quantity * unit_price
end

def sku
    rand(1e8...1e9).to_i
end

def processed_no_delete_error
    # if 
    # end

end

def get_most_recent_purchase_order
    PurchaseOrder.order("created_at").last
    # binding.pry
end

##

def bad_seed_data
    PurchaseOrder.all.select do |order|
        order.vendor_id == 0 || order.vendor_id == nil 
    end
end

def delete(bad_seed_data)
    bad_seed_data.each do |obj|
        PurchaseOrder.destroy(obj.id)
    end
end



# def purchase_order_prompts
#     prompt.ask("Please select a Product")
# end