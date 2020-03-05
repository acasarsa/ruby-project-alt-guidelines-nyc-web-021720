
#downcase if they have to create a vendor name match 
# have a initial step where you select from high level options [product, vendor, PO, search]

def start_program
    # default state when program is initialized

    # create an array of hashes that will be user options w/ returning value
    choices = [
        {name: 'Vendor options', value: 1},
        {name: 'Product options', value: 2},
        {name: 'Purchase Order options', value: 3},
        {name: 'Exit Program', value: 4}
        ]
    prompt = TTY::Prompt.new(symbols: {marker: '👉'}) # creates instance of prompt
    response = prompt.select('Welcome, please select an option:', choices) # execute prompt to user
    
    # filter user response and call appropriate method
    case response
    when 1
        option_choices = [
            {name: 'Create', value: 1},
            {name: 'Update', value:2},
            {name: 'Delete', value: 3},
            {name: 'View all', value: 4}
        ]
        vendor_response = prompt.select('Please select a Vendor option:', option_choices)
        # filter user response and call appropriate method    
        case vendor_response
            when 1
                #create vendor
                new_vendor = prompt.ask('What is the name of the Vendor?', default: ENV['USER'])
                create_vendor(new_vendor)
            when 2
                #update vendor
                pick_vendor = prompt.select('Which vendor do you wish to update?', all_vendor_names, filter: true)
                new_vendor_name = prompt.ask('What is the updated vendor name?', required: true)
                update_vendor_name(pick_vendor, new_vendor_name)
            when 3
                #delete vendor
                pick_vendor = prompt.select('Which vendor do you wish to update?', all_vendor_names, filter: true)
                delete_vendor_check = prompt.yes?("ARE YOU SURE YOU WANT TO DELETE '#{pick_vendor}?")
                # if TRUE user selected they were sure they wanted to delete the vendor
                if delete_vendor_check == true 
                    delete_vendor(pick_vendor)
                end
            when 4
                #view all
                Vendor.all.each do |vendor_name|
                    puts vendor_name.name
                end
        end 

    when 2
#create_product
        product_choices = [
            {name: 'Create', value: 1},
            {name: 'Update', value:2},
            {name: 'Delete', value: 3},
            {name: 'View all', value: 4}
        ]
        product_response = prompt.select('Please select a Product option:', product_choices)

        case product_response # if p_r == 1 do ...when 
            when 1 # create was selected 
                #create product
                new_product = prompt.ask('What is the name of the Product?', default: ENV['USER'])
                create_product(new_product)
            when 2
                #update product
                pick_product = prompt.select('Which Product do you wish to update?', all_product_names, filter: true)
                new_product_name = prompt.ask('What is the updated Product name?', required: true)
                update_product(pick_product, new_product_name)
            when 3
                #delete product
                pick_product = prompt.select('Which Product would you like to delete?', all_product_names, filter: true)
                delete_product_check = prompt.yes?("ARE YOU SURE YOU WANT TO DELETE #{pick_product}")
                if delete_product_check == true
                    delete_product(pick_product)
                end

            when 4
            #view all
            Product.all.map do |p|
                puts "#{p.name}"
            end
            
        end 

    when 3
        #create_purchase_order
        po_choices = [
            {name: 'Create', value: 1},
            {name: 'Update', value:2},
            {name: 'View specific order', value: 3}
        ]
        po_response = prompt.select('Please select a Purchase Order option:', po_choices)

        case po_response
            when 1
                #create po
                
                product_name = prompt.select("Select your Product:", all_product_names, filter: true)
                vendor_name = prompt.select("Select your Vendor:", all_vendor_names, filter: true)
                quantity = prompt.ask("Enter Unit Quantity:") do |q|
                    q.validate /[1-9]/
                end
                unit_price = prompt.ask("Enter Unit Price:") do |price|
                    price.required :true
                    price.convert :float
                    price.validate /[0-9]/
                end
                create_purchase_order(product_name, vendor_name, quantity, unit_price)

                new_po = get_most_recent_purchase_order
                puts "Purchase Order ##{new_po.id} created."
            when 2
                #update po
                update_purchase_order = prompt.select("Select Order Number to Update:", all_purchase_order_numbers.sort.reverse, filter: true)
                po_instance = PurchaseOrder.find_by_id(update_purchase_order)
                choices = [
                    {name: "Vendor", value: 1},
                    {name: "Product", value: 2},
                    {name: "Quantity", value: 3},
                    {name: "Unit Price", value: 4}
                ]
                update_selection = prompt.select("What would you like to update?", choices)
                    case update_selection
                        when 1
                            # Update Vendor on P/O
                            selected_vendor_name = Vendor.find_by_id(po_instance.vendor_id).name
                            pick_vendor = prompt.select("Current vendor on this P/O is #{selected_vendor_name}, select correct Vendor:", all_vendor_names, filter: true)
                            update_po_vendor_name(update_purchase_order, pick_vendor)
                            puts "Successfully updated Vendor name to #{pick_vendor}."

                        when 2
                            # Update Product on P/O
                            selected_product_name = Product.find_by_id(po_instance.product_id).name
                            pick_product = prompt.ask("Current product on this P/O is #{selected_product_name}, select correct Product:", )
                            update_po_product_name(update_purchase_order, pick_product)
                            puts "Successfully updated Product name to #{pick_product}"
                        when 3
                            # Update Quantity on
                            selected_quantity = PurchaseOrder.find_by_id(update_purchase_order)
                            quantity = prompt.ask("Current quantity is #{selected_quantity.quantity}. Enter New Unit Quantity:") do |q|
                                q.validate /[1-9]/
                            end
                            update_po_quantity(update_purchase_order, quantity)
                            puts "Successfully updated Quantity to #{quantity}"
                        when 4
                            # Update unit_price
                            selected_unit_price = PurchaseOrder.find_by_id(update_purchase_order)
                            unit_price = prompt.ask("Current Unit Price is #{selected_unit_price.unit_price}. Enter New Unit Price:") do |price|
                                price.required :true
                                price.convert :float
                                price.validate /[0-9]/
                            end
                            update_po_price(update_purchase_order, unit_price)
                            puts "Successfully updated Price to #{unit_price}"
                    end

            when 3
                #view specific order
                view_purchase_order = prompt.select("Select Order Number to view:", all_purchase_order_numbers.sort.reverse, filter: true)
                po_instance = PurchaseOrder.find_by_id(view_purchase_order)
                # binding.pry
                puts "Order Date: #{po_instance.order_date}"
                puts "Vendor: #{Vendor.find_by_id(po_instance.vendor_id).name}"
                puts "Product: #{Product.find_by_id(po_instance.product_id).name}"
                puts "Product Sku: #{po_instance.sku}"
                puts "Order Quantity: #{po_instance.quantity}"
                puts "Unit Price: #{po_instance.unit_price}"
                # puts "Order total: #{po_instance.total_unit_price}"


            
        end 
    when 4
        $exit_program_boolean = true
    end 
end 

