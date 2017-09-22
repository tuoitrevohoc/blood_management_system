class AddPatientToHistories < ActiveRecord::Migration[5.0]
  def change
    add_reference :histories, :patient, foreign_key: true
  end
end
