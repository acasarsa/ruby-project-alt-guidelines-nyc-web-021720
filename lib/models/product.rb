class Product < ActiveRecord::Base
    has_many :purchase_orders
    has_many :vendors, through: :purchase_orders
end