class DropDefaultValueForEmail < ActiveRecord::Migration[5.0]
  def change
    change_column :users, :email, :string, null: true
    change_column :users, :is_public_profile, :boolean, default: false
  end
end
