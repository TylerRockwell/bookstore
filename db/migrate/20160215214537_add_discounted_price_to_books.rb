class AddDiscountedPriceToBooks < ActiveRecord::Migration
  def change
    add_column :books, :discounted_price, :float
  end
end
