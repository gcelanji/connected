class UpdateStatusColumn < ActiveRecord::Migration[7.0]
  def change
    change_column :connections, :status, "integer USING status::integer"

    change_column_default :connections, :status, 0
  end
end
