class CreatePatients < ActiveRecord::Migration[5.0]
  def change
    create_table :patients do |t|
      t.string :name
      t.date :birthday
      t.integer :gender
      t.integer :blood_type
      t.string :pathological
      t.string :room_number
      t.string :phone_number
      t.string :phone_number_2
      t.string :address
      t.text :history_of_pathology
      t.string :description

      t.timestamps
    end
  end
end
