
#downcase if they have to create a vendor name match 
# have a initial step where you select from high level options [product, vendor, PO, search]

def start_program
    # default state when program is initialized

    # create an array of hashes that will be user options w/ returning value
    choices = [
        {name: 'Vendor options'+"\n", value: 1},
        {name: 'Product options'+"\n", value: 2},
        {name: 'Purchase Order options'+"\n", value: 3},
        {name: 'Exit Program'+"\n", value: 4}
        ]
    prompt = TTY::Prompt.new(symbols: {marker: '👉'}) # creates instance of prompt
    response = prompt.select("\nWelcome, please select an option:\n", choices) # execute prompt to user
    
    # filter user response and call appropriate method
    case response
    when 1
        option_choices = [
            {name: 'Create'+"\n", value: 1},
            {name: 'Update'+"\n", value:2},
            {name: 'Delete'+"\n", value: 3}, 
            {name: "View all\n", value: 4}
        ]
        vendor_response = prompt.select('Please select a Vendor option:'+"\n", option_choices)
        # filter user response and call appropriate method    
        case vendor_response
            when 1
                #create vendor
                new_vendor = prompt.ask('What is the name of the Vendor?'+"\n", default: ENV['USER'])
                create_vendor(new_vendor)
            when 2
                #update vendor
                pick_vendor = prompt.select('Which vendor do you wish to update?'+"\n", all_vendor_names, filter: true)
                new_vendor_name = prompt.ask('What is the updated vendor name?'+"\n", required: true)
                update_vendor_name(pick_vendor, new_vendor_name)
            when 3
                #delete vendor
                pick_vendor = prompt.select('Which vendor do you wish to update?'+"\n", all_vendor_names, filter: true)
                delete_vendor_check = prompt.yes?("ARE YOU SURE YOU WANT TO DELETE #{pick_vendor}?"+"\n", help_color: :red)
                    # can stick prompt.warn inside the () but it repeats the phrase once in yellow once in white.

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
            {name: 'Create'+"\n", value: 1},
            {name: 'Update'+"\n", value:2},
            {name: 'Delete'+"\n", value: 3},
            {name: "View all\n", value: 4}
        ]
        product_response = prompt.select('Please select a Product option:'+"\n", product_choices)

        case product_response # if p_r == 1 do ...when 
            when 1 # create was selected 
                #create product
                new_product = prompt.ask('What is the name of the Product?'+"\n", default: ENV['USER'])
                create_product(new_product)
            when 2
                #update product
                pick_product = prompt.select('Which Product do you wish to update?'+"\n", all_product_names, filter: true)
                new_product_name = prompt.ask('What is the updated Product name?'+"\n", required: true)
                update_product(pick_product, new_product_name)
            when 3
                #delete product
                pick_product = prompt.select('Which Product would you like to delete?'+"\n", all_product_names, filter: true)
                delete_product_check = prompt.yes?("ARE YOU SURE YOU WANT TO DELETE #{pick_product}"+"\n")
                if delete_product_check == true
                    delete_product(pick_product)
                end

            when 4
            #view all
            Product.all.map do |p|
                puts p.name
            end
            
        end 

    when 3
        #create_purchase_order
        po_choices = [
            {name: 'Create'+"\n", value: 1},
            {name: 'Update'+"\n", value:2},
            {name: 'View specific order'+"\n", value: 3}
        ]
        po_response = prompt.select('Please select a Purchase Order option:'+"\n", po_choices)

        case po_response
            when 1
                #create po
                
                product_name = prompt.select("Select your Product:"+"\n", all_product_names, filter: true)
                vendor_name = prompt.select("Select your Vendor:"+"\n", all_vendor_names, filter: true)
                quantity = prompt.ask("Enter Unit Quantity:"+"\n") do |q|
                    q.validate /[1-9]/
                end
                unit_price = prompt.ask("Enter Unit Price:"+"\n") do |price|
                    price.required :true
                    price.convert :float
                    price.validate /[0-9]/
                end
                create_purchase_order(product_name, vendor_name, quantity, unit_price)

                new_po = get_most_recent_purchase_order
                puts "Purchase Order ##{new_po.id} created."+"\n"
            when 2
                #update po
                update_purchase_order = prompt.select("Select Order Number to Update:\n", all_purchase_order_numbers.sort.reverse, filter: true) #
                po_instance = PurchaseOrder.find_by_id(update_purchase_order)
                choices = [
                    {name: "Vendor\n", value: 1},
                    {name: "Product\n", value: 2},
                    {name: "Quantity\n", value: 3},
                    {name: "Unit Price\n", value: 4}
                ]
                update_selection = prompt.select("What would you like to update?\n", choices)
                    case update_selection
                        when 1
                            # Update Vendor on P/O
                            selected_vendor_name = Vendor.find_by_id(po_instance.vendor_id).name
                            pick_vendor = prompt.select("Current vendor on this P/O is #{selected_vendor_name}, select correct Vendor:"+"\n", all_vendor_names, filter: true)
                            update_po_vendor_name(update_purchase_order, pick_vendor)
                            puts "Successfully updated Vendor name to #{pick_vendor}."+"\n"

                        when 2
                            # Update Product on P/O
                            selected_product_name = Product.find_by_id(po_instance.product_id).name
                            pick_product = prompt.select("Current product on this P/O is #{selected_product_name}, select correct Product:"+"\n", all_product_names, filter: true)
                            update_po_product_name(update_purchase_order, pick_product)
                            puts "Successfully updated Product name to #{pick_product}"+"\n"
                        when 3
                            # Update Quantity on
                            selected_quantity = PurchaseOrder.find_by_id(update_purchase_order)
                            quantity = prompt.ask("Current quantity is #{selected_quantity.quantity}. Enter New Unit Quantity:") do |q|
                                q.validate /[1-9]/
                            end
                            update_po_quantity(update_purchase_order, quantity)
                            puts "Successfully updated Quantity to #{quantity}"+"\n"
                            print_out_po(update_purchase_order)
                        when 4
                            # Update unit_price
                            selected_unit_price = PurchaseOrder.find_by_id(update_purchase_order)
                            unit_price = prompt.ask("Current Unit Price is #{selected_unit_price.unit_price}. Enter New Unit Price:") do |price|
                                price.required :true
                                price.convert :float
                                price.validate /[0-9]/
                            end
                            update_po_price(update_purchase_order, unit_price)
                            puts "Successfully updated Price to #{unit_price}"+"\n"
                            print_out_po(update_purchase_order)
                    end

            when 3
                #view specific order
                
                view_purchase_order = prompt.select("Select Order Number to view:"+"\n", all_purchase_order_numbers.sort.reverse, filter: true)
                print_out_po(view_purchase_order)            
        end 
    when 4
        $exit_program_boolean = true
    end 
end 

