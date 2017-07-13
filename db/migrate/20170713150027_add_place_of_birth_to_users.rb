class AddPlaceOfBirthToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :place_of_birth, :string
  end
end
