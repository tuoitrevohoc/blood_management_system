class AddIndexToArticleTitleSlug < ActiveRecord::Migration[5.0]
  def change
    add_index :articles, :title_slug
  end
end
