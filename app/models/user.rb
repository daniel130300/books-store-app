class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_one :address
  has_many :friendships
  has_many :friends, through: :friendships

  validates_presence_of :fullname
  validates_presence_of :birth_date 
end
