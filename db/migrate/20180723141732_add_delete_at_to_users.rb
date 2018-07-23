class AddDeleteAtToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :deleted_at, :datetime
    add_column :users, :reason_for_deleting, :string
    add_index :users, :deleted_at
  end
end
