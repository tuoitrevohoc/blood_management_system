class CreateAdminHistories < ActiveRecord::Migration[5.0]
  def change
    create_table :admin_histories do |t|
      t.references :user, foreign_key: true
      t.references :place, foreign_key: true
      t.timestamp :start_time
      t.timestamp :end_time
      t.integer :admin_id

      t.timestamps
    end
  end
end
