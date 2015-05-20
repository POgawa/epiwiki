class DropRevisionsTable < ActiveRecord::Migration
  def change
    drop_table :revisions
  end
end
