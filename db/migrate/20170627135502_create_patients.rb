class CreatePatients < ActiveRecord::Migration[5.0]
  def change
    create_table :patients do |t|
      t.string :name
      t.integer :age
      t.string :pathological
      t.string :phone_number
      t.string :address
      t.string :description

      t.timestamps
    end
  end
end
