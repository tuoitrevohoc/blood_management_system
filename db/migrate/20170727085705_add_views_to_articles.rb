class AddViewsToArticles < ActiveRecord::Migration[5.0]
  def change
    add_column :articles, :views, :integer, default: 0
    add_column :events, :views, :integer, default: 0
  end
end
