class AddIsPublicToArticle < ActiveRecord::Migration[5.0]
  def change
    add_column :articles, :is_public, :boolean, default: false
  end
end
