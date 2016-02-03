class CreateCarts < ActiveRecord::Migration
  def change
    create_table :carts do |t|
      t.references :user, index: true, foreign_key: true
      t.decimal :total, precision: 12, scale: 3

      t.timestamps null: false
    end
  end
end
