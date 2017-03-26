class CreateEventImages < ActiveRecord::Migration[5.0]
  def change
    create_table :event_images do |t|
      t.string :image
      t.string :caption
      t.references :event, foreign_key: true

      t.timestamps
    end
  end
end
