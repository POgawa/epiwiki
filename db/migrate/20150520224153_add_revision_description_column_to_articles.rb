class AddRevisionDescriptionColumnToArticles < ActiveRecord::Migration
  def change
    add_column :articles, :revision_description, :string
  end
end
