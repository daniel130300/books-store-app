class Address < ApplicationRecord
    belongs_to :user
    validates :address_line_1, presence: true, length: { minimum: 10, maximum: 50 } 
    validates :city, presence: true, length: { minimum: 3, maximum: 20 } 
    validates :state_or_province, presence: true, length: { minimum:10, maximum:300 }
    validates :postal_code, presence: true, length: { minimum:3, maximum:5 } 
    validates :telephone, presence: true, length: { minimum: 8, maximum: 10 }
end