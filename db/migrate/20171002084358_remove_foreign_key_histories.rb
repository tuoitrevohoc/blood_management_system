class RemoveForeignKeyHistories < ActiveRecord::Migration[5.0]
  def change
    remove_foreign_key :histories, :patients
  end
end
