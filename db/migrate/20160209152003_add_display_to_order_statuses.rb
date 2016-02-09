class AddDisplayToOrderStatuses < ActiveRecord::Migration
  def change
    add_column :order_statuses, :display, :string
  end
end
