class Connection < ApplicationRecord
  belongs_to :user
  belongs_to :connection, class_name: 'User'

  enum status: [:pending, :accepted, :deleted]
end
