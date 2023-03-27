class SharedPost < ApplicationRecord
  belongs_to :user
  belongs_to :post
  has_many :likes, as: :post, dependent: :destroy
  validates :post, presence: true, uniqueness: { scope: :user }
end
