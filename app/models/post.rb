class Post < ApplicationRecord
  enum :visibility, [:everyone, :connections, :onlyme], default: :everyone

  # associations
  belongs_to :user
end
