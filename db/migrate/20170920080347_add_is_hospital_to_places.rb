class AddIsHospitalToPlaces < ActiveRecord::Migration[5.0]
  def change
    add_column :places, :is_hospital, :boolean, default: true
  end
end
