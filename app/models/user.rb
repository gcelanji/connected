class User < ApplicationRecord
  # validations
  validates :first_name, :last_name, :birth_date, presence: true
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  # associations
  has_many :posts
  has_many :likes
  has_many :comments
  has_many :shared_posts
  has_many :posts, through: :shared_posts

  def full_name
    "#{first_name} #{last_name}"
  end
end
