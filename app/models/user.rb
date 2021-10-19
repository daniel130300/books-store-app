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

  def self.search(id, search)
    search.strip!
    user = self.where.not(id: id).and(self.where("email like ?", "%#{search}%").or(self.where("first_name like ?", "%#{search}%")).or(self.where("last_name like ?", "%#{search}%")))
    return nil unless user
    user
  end

  def not_friends_with?(id_of_friend)
    !self.friends.where(id: id_of_friend).exists?
  end
  
end
