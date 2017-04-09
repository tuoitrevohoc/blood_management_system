class AddFieldsToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :is_public_profile, :boolean, default: true
    add_column :users, :is_volunteer, :boolean, default: true
  end
end
