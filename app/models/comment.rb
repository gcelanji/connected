class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :post, polymorphic: true

  broadcasts_to ->(comment) { "comments" }, inserts_by: :append
end
