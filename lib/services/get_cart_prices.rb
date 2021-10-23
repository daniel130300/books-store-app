module Services
    class GetCartPrices < ApplicationService
        TAX_RATE = 0.12
        attr_reader :shopping_cart

        def initialize(shopping_cart)
            @shopping_cart = shopping_cart
        end

        def call
            values = { subtotal: 0 , tax: 0, total: 0 }

            @shopping_cart.map do |cart|
                values[:subtotal] += (price_without_tax(cart[:price]) * cart[:quantity])
                values[:tax] += (extract_tax(cart[:price]) * cart[:quantity])
            end
            values[:subtotal] = values[:subtotal].round(2)
            values[:tax] = values[:tax].round(2)
            values[:total] = (values[:subtotal] + values[:tax])
            return values
        end

        private 

        def price_without_tax(full_price)
            full_price/(1+TAX_RATE)
        end

        def extract_tax(full_price)
            (full_price * TAX_RATE)/(1+TAX_RATE)
        end
    end
end