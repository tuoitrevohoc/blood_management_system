class AddDonationTypeToHistories < ActiveRecord::Migration[5.0]
  def change
    add_column :histories, :donation_type, :integer
    add_column :histories, :platelet_count, :integer
    remove_column :histories, :volume
  end
end
