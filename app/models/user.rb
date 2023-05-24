class User < ApplicationRecord
  # validations
  validates :first_name, :last_name, :birth_date, presence: true
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  # associations
  has_many :posts, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :shared_posts, dependent: :destroy
  has_many :connections, foreign_key: :user_id
  has_many :connected_users, foreign_key: :connection_id, class_name: 'Connection'

  def full_name
    "#{first_name} #{last_name}"
  end

  def active_connections
    connections.accepted + connected_users.accepted
  end

  def self.ransackable_attributes(auth_object = nil)
    ["birth_date", "created_at", "email", "encrypted_password", "first_name", "id", "last_name", "remember_created_at", "reset_password_sent_at", "reset_password_token", "updated_at"]
  end

  def self.ransackable_associations(auth_object = nil)
    ["comments", "likes", "posts", "shared_posts"]
  end
end
