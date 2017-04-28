class AddFormatedAddressToUser < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :formatted_address, :string
  end
end
