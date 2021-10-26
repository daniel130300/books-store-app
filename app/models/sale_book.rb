class SaleBook < ApplicationRecord
    belongs_to :sale
    belongs_to :book
end