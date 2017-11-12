class CreateArticles < ActiveRecord::Migration[5.1]
  def change
    create_table :articles do |t|
      t.text :annotation
      t.string :title
      t.datetime :published_at
      t.timestamps
    end
  end
end
