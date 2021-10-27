class User < ApplicationRecord

  attr_accessor :already_friends
  include PgSearch::Model

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :validatable

  has_one :address
  has_many :friendships
  has_many :friends, through: :friendships
  has_many :wishlists
  has_many :wish_books, through: :wishlists, source: 'book'
  has_many :shopping_carts
  has_many :cart_books, through: :shopping_carts, source: 'book'
  has_many :sales
  has_many :sale_books, through: :sales

  pg_search_scope :search_friend,
                  against: [:fullname, :email],
                  using: :dmetaphone

  validates_presence_of :fullname
  validates_presence_of :birth_date 

  def not_friends_with?(id_of_friend)
    !self.friends.where(id: id_of_friend).exists?
  end

  def already_in_wishlist?(book)
    self.wish_books.where(id:book).exists?
  end

  def already_in_cart?(book)
    self.cart_books.where(id:book).exists?
  end

  def self.search(friend, current_user)
    self.search_friend(friend).where.not(id: current_user).and(self.where.not(admin: true))
  end

end
