class SharedPost < ApplicationRecord
  belongs_to :user
  belongs_to :post
  validates :post, presence: true, uniqueness: { scope: :user }
end
