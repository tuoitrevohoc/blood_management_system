class AddDeleteAtToHistories < ActiveRecord::Migration[5.0]
  def change
    add_column :histories, :deleted_at, :datetime
    add_index :histories, :deleted_at
  end
end
