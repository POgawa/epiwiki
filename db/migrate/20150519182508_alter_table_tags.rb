class AlterTableTags < ActiveRecord::Migration
  def up
    add_column :tags, :topic, :string
  end

  def down
    remove_column :tags, :name, :string
  end
end
