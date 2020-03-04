def say_hello
    puts "Hi, Hello!"
end 

def create_vendor(vendor_name)
    Vendor.create(name: vendor_name)
end 

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


