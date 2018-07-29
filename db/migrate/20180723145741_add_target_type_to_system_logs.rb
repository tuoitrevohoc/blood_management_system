class AddTargetTypeToSystemLogs < ActiveRecord::Migration[5.0]
  def change
    add_column :system_logs, :target_type, :string
  end
end
