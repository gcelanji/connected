class Post < ApplicationRecord
  enum :visibility, [:everyone, :connections, :onlyme], default: :everyone

  # associations
  belongs_to :user
  has_many :likes
  has_many :comments
end
