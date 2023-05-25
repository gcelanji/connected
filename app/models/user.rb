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
    connection_ids = connections.accepted.pluck(:connection_id) + connected_users.accepted.pluck(:user_id)
    User.find(connection_ids).uniq
  end

  def has_a_pending_request_from(user)
    connected_users.pending.map(&:user_id).include?(user.id)
  end

  def sent_a_request_to(user)
    connections.pending.map(&:connection_id).include?(user.id)
  end

  def is_a_connection_with(user)
    connected_users.accepted.map(&:user_id).include?(user.id) || connections.accepted.map(&:connection_id).include?(user.id)
  end

  def connection_from(user)
      connections.where(connection: user).first || connected_users.where(user: user).first
  end

  def self.ransackable_attributes(auth_object = nil)
    ["birth_date", "created_at", "email", "encrypted_password", "first_name", "id", "last_name", "remember_created_at", "reset_password_sent_at", "reset_password_token", "updated_at"]
  end

  def self.ransackable_associations(auth_object = nil)
    ["comments", "likes", "posts", "shared_posts"]
  end
end
