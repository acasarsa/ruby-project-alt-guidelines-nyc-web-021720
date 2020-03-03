class Vendor < ActiveRecord::Base
    has_many :inventory_entries
    has_many :products, through: :inventory_entries
end