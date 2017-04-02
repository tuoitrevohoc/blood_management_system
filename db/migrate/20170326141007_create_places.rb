class CreatePlaces < ActiveRecord::Migration[5.0]
  def change
    create_table :places do |t|
      t.string :name
      t.string :address
      t.float :logititude
      t.float :latitude

      t.timestamps

      t.index :name
      t.index :address
      t.index [:name, :address], unique: true
    end
  end
end
