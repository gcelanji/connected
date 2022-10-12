class Post < ApplicationRecord
  belongs_to :user

  enum :visibility, [:everyone, :connections, :onlyme], default: :everyone
end
