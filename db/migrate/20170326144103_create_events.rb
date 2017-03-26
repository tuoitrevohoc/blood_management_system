class CreateEvents < ActiveRecord::Migration[5.0]
  def change
    create_table :events do |t|
      t.string :title
      t.string :content
      t.references :place, foreign_key: true
      t.references :user

      t.timestamps

      t.index :title
    end
  end
end
