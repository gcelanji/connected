class ChangeBirthDateToDateInUsers < ActiveRecord::Migration[7.0]
  def change
    change_column :users, :birth_date, :date
  end
end
