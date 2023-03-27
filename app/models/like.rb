class Like < ApplicationRecord
  validates :user_id, uniqueness: { scope: [:post_id, :post_type] }
  belongs_to :user
  belongs_to :post, polymorphic: true
end
