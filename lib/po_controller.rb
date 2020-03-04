def say_hello
    puts "Hi, Hello!"
end 

def create_vendor(vendor_name)
    Vendor.create(name: vendor_name)
end 

<<<<<<< HEAD
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
=======
# product po_controller

def all_product_names
    Product.all.map do |p|
        p.name
    end
end

def create_product(product_name)
    Product.create(name: product_name)
end

def update_product(old_name, new_name)
    update_product = Product.find_by name: old_name
    update_product.name = new_name
    update_product.save
end

def delete_product(product)
    product_to_delete = Product.find_by name: product
    puts "#{product} has been deleted"
    Product.delete(product_to_delete)
end


>>>>>>> 2d3a5e7b3cc96e3e0a07682347a2eaef02f5a003
