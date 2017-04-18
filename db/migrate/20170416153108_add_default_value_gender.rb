class AddDefaultValueGender < ActiveRecord::Migration[5.0]
  def change
    change_column_default :users, :gender, 0
  end
end
