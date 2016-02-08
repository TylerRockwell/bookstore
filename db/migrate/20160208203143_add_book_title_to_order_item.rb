class AddBookTitleToOrderItem < ActiveRecord::Migration
  def change
    add_column :order_items, :book_title, :string
  end
end
