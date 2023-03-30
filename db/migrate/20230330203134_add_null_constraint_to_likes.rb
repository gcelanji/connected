class AddNullConstraintToLikes < ActiveRecord::Migration[7.0]
  def change
    change_column_null :likes, :post_type, false
  end
end
