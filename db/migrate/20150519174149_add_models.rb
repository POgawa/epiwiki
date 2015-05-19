class AddModels < ActiveRecord::Migration
  def change

    create_table :articles do |t|
      t.string :content
      t.string :name

      t.timestamps
    end

    create_table :tags do |t|
      t.string :name

      t.timestamps
    end

    create_table :users do |t|
      t.string :name

      t.timestamps
    end

    create_join_table(:articles, :tags)
    create_join_table(:articles, :users)
  end


end
