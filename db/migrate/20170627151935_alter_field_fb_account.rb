class AlterFieldFbAccount < ActiveRecord::Migration[5.0]
  def change
    remove_column :histories, :facebook_account
    add_column :users, :facebook_account, :string
  end
end
