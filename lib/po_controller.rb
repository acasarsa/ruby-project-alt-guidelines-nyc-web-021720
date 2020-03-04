def say_hello
    puts "Hi, Hello!"
end 

def create_vendor(vendor_name)
    Vendor.create(name: vendor_name)
end 

# method to pull all 