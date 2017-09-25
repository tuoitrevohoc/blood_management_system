class CreateDepartments < ActiveRecord::Migration[5.0]
  def change
    create_table :departments do |t|
      t.references :place, foreign_key: true
      t.string :name
      t.string :head_doctor

      t.timestamps
    end
  end
end
