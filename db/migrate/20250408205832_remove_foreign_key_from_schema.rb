class RemoveForeignKeyFromSchema < ActiveRecord::Migration[8.0]
  def change
     remove_foreign_key :likes, :posts
     remove_foreign_key :comments, :posts
  end
end
