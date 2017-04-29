class FormattedAddressToPlaces < ActiveRecord::Migration[5.0]
  def change
    add_column :places, :formatted_address, :string
    rename_column :places, :logititude, :longitude
  end
end
