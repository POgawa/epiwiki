class AddUserIdToRelation < ActiveRecord::Migration
  def change
    add_column :revisions, :user_id, :integer
  end
end
