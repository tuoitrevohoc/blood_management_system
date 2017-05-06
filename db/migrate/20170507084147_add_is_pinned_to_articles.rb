class AddIsPinnedToArticles < ActiveRecord::Migration[5.0]
  def change
    add_column :articles, :is_pinned, :boolean, default: false
  end
end
