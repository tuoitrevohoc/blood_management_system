class AddOtherVolumeToHistories < ActiveRecord::Migration[5.0]
  def change
    add_column :histories, :other_volume, :integer
    change_column_default :histories, :volume, nil
  end
end
