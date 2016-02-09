class RemoveBookIdFromOrderItems < ActiveRecord::Migration
  def change
    remove_column :order_items, :book_id, :integer
  end
end
