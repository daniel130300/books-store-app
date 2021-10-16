class Book < ApplicationRecord
    validates :purchase_price, presence: true, length: {minimum:2, maximum:4}, format: { with: /[1-9]\d*(\.\d+)?/, message: "only numbers are allowed" }
    validates :sale_price, presence: true, length: {minimum:2, maximum:4}, numericality: { only_integer: true }
    validates :quantity, presence: true, length: {minimum:1, maximum:3}, numericality: { only_integer: true }
end
