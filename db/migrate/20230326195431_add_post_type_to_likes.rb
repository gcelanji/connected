class AddPostTypeToLikes < ActiveRecord::Migration[7.0]
  def change
    add_column :likes, :post_type, :string

    add_index :likes, [:post_type, :post_id]
  end
end
