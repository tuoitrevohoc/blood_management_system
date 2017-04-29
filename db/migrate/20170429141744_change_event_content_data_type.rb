class ChangeEventContentDataType < ActiveRecord::Migration[5.0]
  def change
    change_column :events, :content, :text
  end
end
