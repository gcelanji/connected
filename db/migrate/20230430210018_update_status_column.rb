class UpdateStatusColumn < ActiveRecord::Migration[7.0]
  def change
    change_column :connections, :status, :integer, default: 0
  end
end
