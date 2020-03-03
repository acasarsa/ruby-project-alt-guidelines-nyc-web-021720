class Product < ActiveRecord::Base
    has_many :inventory_entries
    has_many :vendors, through: :inventory_entries
end