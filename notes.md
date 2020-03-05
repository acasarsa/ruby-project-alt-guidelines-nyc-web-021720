# Purchase Order Manager for a store product buyer
## keeps track of list of purchases from different vendors 
    - can create new purchase orders
    - can create new vendors
    - can create new products
    - can get list of open/closed purchase orders
    - can get list of vendors
    - can get list of products

# Products
    - has many inventory entries
# Vendor_products
    - belongs to products
    - belongs to vendors
    - has foreign id for product and vendor
# Purchase_order
    - has many inventory entries

# Things to add
`    - change join table to 'purchase_order'`
    - add columns for vendor business info
`    - change purchase_order: inv to quantity: `
`    - column for sku `
`    - change inv: to quantity:`
`    - change price to :unit_price`
`     - add total unit price column to purchase order table`
`    - add order processed`
`    - add order date `
`    - add processed state column for purchase order`
    - user can set order to processed == true
    
    - CRUD
        - product_order.where = date - returns all orders for that date
        - Create new vendor / product / purchase order
        - Read - view purchase orders
        - Update product info / vendor info / purchase order info (unless order isn't processed)
        - Delete vendor if no purchases have been made

    
# Soft goals
    - inventory management
    - column for suggested list price - in product
    - column for bulk price discount inside 'vendor_products'
    - ability to repeat historical purchase orders 
        stretch goal- repeat based on product type or vendor or date

# User actions
    - see what vendors currently used
    - see what # of products purchased

# Stretch goal
    - color things in terminal output
