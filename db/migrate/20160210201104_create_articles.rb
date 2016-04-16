class CreateArticles < ActiveRecord::Migration
  def change
    create_table :articles do |t|
      t.integer :user_id
      t.string :title
      t.text :text
      t.string :category
      t.integer :grade

      t.timestamps null: false
    end
    add_index :articles, [:user_id, :created_at]
  end
end
