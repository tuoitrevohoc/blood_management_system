class CreateSystemLogs < ActiveRecord::Migration[5.0]
  def change
    create_table :system_logs do |t|
      t.integer :action_type
      t.integer :target_id
      t.integer :actor_id
      t.string :description

      t.timestamps
    end
    add_index :system_logs, :action_type
    add_index :system_logs, :target_id
  end
end
