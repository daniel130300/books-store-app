module Services
    class GetCartPrices < ApplicationService
        TAX_RATE = 0.12

        def initialize(element)
            @element = element
        end

        def call
            values = { subtotal: 0 , tax: 0, total: 0 }
            if (@element.respond_to?(:each))
                @element.map do |cart_item|
                    values[:subtotal] += (price_without_tax(cart_item[:price]) * cart_item[:quantity])
                    values[:tax] += (extract_tax(cart_item[:price]) * cart_item[:quantity])
                end
                values[:subtotal] = values[:subtotal].round(2)
                values[:tax] = values[:tax].round(2)
                values[:total] = (values[:subtotal] + values[:tax])
            else
                values[:subtotal] += (price_without_tax(@element[:sale_price]))
                values[:tax] += (extract_tax(@element[:sale_price]))
                values[:total] = (values[:subtotal] + values[:tax])
            end

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