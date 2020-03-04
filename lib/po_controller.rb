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
