class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  has_many :exercises
  has_many :friendships
  has_many :friends, through: :friendships, class_name: "User"

  validates :first_name, presence: true
  validates :last_name, presence: true

  self.per_page = 10

  def full_name
    "#{first_name} #{last_name}"
  end

  def self.search_by_name(name)
    names_array = name.split(' ')

    if names_array.size == 1
      where('first_name LIKE ? OR last_name LIKE ?',
        "%#{names_array[0]}%", "%#{names_array[0]}%").order(:first_name)
    else
      where('first_name LIKE ? OR first_name LIKE ? OR last_name LIKE ?last_name LIKE ?',
        "%#{names_array[0]}%", "%#{names_array[1]}%",
        "%#{names_array[0]}%", "%#{names_array[1]}%").order(:first_name)
    end
  end

  def follows_or_same?(athlete)
    friendships.map(&:friend).include?( athlete ) || self == athlete
  end

  def current_friendship(friend)
    friendships.where(friend: friend).first
  end
end
