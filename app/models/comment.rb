class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :post, polymorphic: true
  validates :user_id, uniqueness: { scope: [:post_id, :post_type] }
end
