class DropIndexUserOnEmail < ActiveRecord::Migration[5.0]
  def change
    change_column_null :users, :email, true
    change_column_default :users, :email, nil
    remove_index :users, :email
    add_index :users, :email
  end
end
