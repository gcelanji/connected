class AddPostTypeToComments < ActiveRecord::Migration[7.0]
  def change
    add_column :comments, :post_type, :string, null: false
  end
end
