class AddImageToEvents < ActiveRecord::Migration[5.0]
  def change
    add_column :events, :image, :string
    add_column :events, :is_public, :boolean, default: false
  end
end
