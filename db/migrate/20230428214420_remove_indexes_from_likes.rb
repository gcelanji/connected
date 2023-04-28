class RemoveIndexesFromLikes < ActiveRecord::Migration[7.0]
  def change
    remove_index :likes, name: "index_likes_on_post_type_and_post_id"
    remove_index :likes, name: "index_likes_on_user_id_and_post_id"
  end
end
