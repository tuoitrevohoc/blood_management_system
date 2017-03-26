class CreateBloodGroups < ActiveRecord::Migration[5.0]
  def change
    create_table :blood_groups do |t|
      t.integer :group

      t.timestamps

      t.index :group, unique: true
    end
  end
end
