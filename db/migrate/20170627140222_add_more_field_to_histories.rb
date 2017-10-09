class AddMoreFieldToHistories < ActiveRecord::Migration[5.0]
  def change
    add_column :histories, :facebook_account, :string
    add_column :histories, :referer, :string
  end
end
