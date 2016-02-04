class RemoveCartIdFromOrderItems < ActiveRecord::Migration
  def change
    remove_column :order_items, :cart_id, :integer
  end
end
