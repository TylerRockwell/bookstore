class RemoveTotalFromOrder < ActiveRecord::Migration
  def change
    remove_column :orders, :total, :decimal
  end
end
