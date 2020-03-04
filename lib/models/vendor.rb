class Vendor < ActiveRecord::Base
    has_many :purchase_orders
    has_many :products, through: :purchase_orders
end