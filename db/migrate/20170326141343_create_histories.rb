class CreateHistories < ActiveRecord::Migration[5.0]
  def change
    create_table :histories do |t|
      t.references :user, foreign_key: true
      t.references :place, foreign_key: true
      t.integer :volume, default: 0
      t.date :date
      t.integer :admin_id
      t.boolean :is_verified, default: false

      t.timestamps

      t.index :date
      t.index [:user_id, :place_id, :date], unique: true
    end
  end
end
