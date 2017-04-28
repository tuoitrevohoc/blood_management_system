class AddLatLonToUser < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :lat, :float
    add_column :users, :lon, :float
    add_index :users, :lat
    add_index :users, :lon
    add_index :users, [:lat, :lon]
  end
end
