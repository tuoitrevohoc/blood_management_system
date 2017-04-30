class AddSlugToEvents < ActiveRecord::Migration[5.0]
  def change
    add_column :events, :title_slug, :string
  end
end
