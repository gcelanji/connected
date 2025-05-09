class ChangeBirthDateToDateInUsers < ActiveRecord::Migration[7.0]
  def up
    change_column :users, :birth_date, 'date USING birth_date::date'
  end

  def down
    change_column :users, :birth_date, :string
  end
end
