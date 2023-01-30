class Post < ApplicationRecord
  enum :visibility, [:everyone, :connections, :onlyme], default: :everyone

  # associations
  belongs_to :user
  has_many :likes, dependent: :destroy
  has_many :comments, dependent: :destroy
end
