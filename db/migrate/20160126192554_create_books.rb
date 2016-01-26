class CreateBooks < ActiveRecord::Migration
  def change
    create_table :books do |t|
      t.string :title
      t.date :published_date
      t.text :author
      t.float :price
      t.text :category
      t.text :description

      t.timestamps null: false
    end
  end
end
