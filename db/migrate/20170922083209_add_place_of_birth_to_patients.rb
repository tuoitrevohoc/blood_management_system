class AddPlaceOfBirthToPatients < ActiveRecord::Migration[5.0]
  def change
    add_column :patients, :place_of_birth, :string
    add_column :patients, :id_number, :string
  end
end
