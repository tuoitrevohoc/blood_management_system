class EditTableArticle < ActiveRecord::Migration[5.0]
  def change
    add_column :articles, :uid, :string
    add_column :events, :uid, :string
  end
end
