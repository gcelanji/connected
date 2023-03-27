class Post < ApplicationRecord
  enum :visibility, [:everyone, :connections, :onlyme], default: :everyone

  # associations
  belongs_to :user
  has_many :likes, as: :post, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :shared_posts
  has_many :users, through: :shared_posts
end
