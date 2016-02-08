class AddOrderIdToAddresses < ActiveRecord::Migration
  def change
    add_reference :addresses, :order, index: true, foreign_key: true
  end
end
