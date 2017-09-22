class AddDepartmentToPatient < ActiveRecord::Migration[5.0]
  def change
    add_reference :patients, :department, foreign_key: true
  end
end
