class AddPhoneNumber2ToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :phone_number_2, :string
    change_column_default :histories, :donation_type, 0
  end
end
