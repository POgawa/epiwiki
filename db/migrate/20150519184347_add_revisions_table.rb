class AddRevisionsTable < ActiveRecord::Migration
  def change
    create_table :revisions do |t|
      t.string :content
      t.integer :article_id

      t.timestamps
    end
  end
end
