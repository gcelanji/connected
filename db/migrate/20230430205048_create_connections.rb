class CreateConnections < ActiveRecord::Migration[7.0]
  def change
    create_table :connections do |t|
      t.integer :user_id
      t.integer :connection_id
      t.string :status

      t.timestamps
    end
  end
end
