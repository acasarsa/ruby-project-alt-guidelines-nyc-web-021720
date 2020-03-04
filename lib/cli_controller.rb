
#downcase if they have to create a vendor name match 
# have a initial step where you select from high level options [product, vendor, PO, search]

def start_program
    # default state when program is initialized

    # create an array of hashes that will be user options w/ returning value
    choices = [
        {name: 'Vendor options', value: 1},
        {name: 'Product options', value: 2},
        {name: 'Purchase Order options', value: 3}
        ]
    prompt = TTY::Prompt.new # creates instance of prompt
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
        prompt_vendor = TTY::Prompt.new # creates instance of prompt
        vendor_response = prompt.select('Please select a Vendor option:', option_choices)
        # filter user response and call appropriate method    
        case vendor_response
            when 1
                #create vendor
                new_vendor = prompt.ask('What is the name of the Vendor?', default: ENV['USER'])
                create_vendor(new_vendor)
            when 2
                #update vendor
            when 3
                #delete vendor
            when 4
                #view all
                puts "YOU SELECTED THE RIGHT ANSWER"
                Vendor.all.each do |vendor_name|
                    # binding.pry
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
                new_product_name = prompt.ask('What is the updated Product name?')
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
            {name: 'Delete', value: 3},
            {name: 'View all', value: 4}
        ]
        po_response = prompt.select('Please select a Purchase Order option:', po_choices)

        case po_response
            when 1
                #create po
            when 2
                #update po
            when 3
                #delete po
            when 4
            #view all
        end 
    end 



end 


# warriors = %w(Scorpion Kano Jax Kitana Raiden)
# prompt.select('Choose your destiny?', warriors, filter: true)
