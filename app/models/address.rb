class Address < ApplicationRecord
    belongs_to :user
    validates :address_line_1, presence: true, length: { minimum: 10, maximum: 50 } 
    validates :city, presence: true, length: { minimum: 3, maximum: 20 }, format: { with:/\A^([a-zA-Z]+\s?)*$\z/, message: "only letters and single spaces between word are allowed"}  
    validates :state_or_province, presence: true, length: { minimum:3, maximum:300 }, format: { with:/\A^([a-zA-Z]+\s?)*$\z/, message: "only letters and single spaces between word are allowed"}
    validates :postal_code, presence: true, length: { minimum:3, maximum:5 }, format: { with:/\A[0-9]*$\z/, message: "only numbers are allowed" } 
    validates :telephone, presence: true, length: { minimum: 8, maximum: 10 }, format: { with:/\A[0-9]*$\z/, message: "only numbers are allowed" }
end