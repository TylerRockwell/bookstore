class CreateAddresses < ActiveRecord::Migration
  def change
    create_table :addresses do |t|
      t.integer :street_number
      t.string :street_name
      t.string :apartment
      t.string :city
      t.string :state
      t.string :zip
      t.references :address_type, index: true, foreign_key: true
      t.references :user, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
