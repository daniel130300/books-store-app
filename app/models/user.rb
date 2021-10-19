class User < ApplicationRecord

  attr_accessor :already_friends

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_one :address
  has_many :friendships
  has_many :friends, through: :friendships

  validates_presence_of :fullname
  validates_presence_of :birth_date 

  def self.search(id, search)
    raise Exceptions::ApiExceptions::FriendError::MissingSearchTerms if search.blank?
    search.strip!
    user = self.where.not(id: id).and(self.where("email like ?", "%#{search}%").or(self.where("fullname like ?", "%#{search}%")))
    return user
  end

  def not_friends_with?(id_of_friend)
    !self.friends.where(id: id_of_friend).exists?
  end
  
end
