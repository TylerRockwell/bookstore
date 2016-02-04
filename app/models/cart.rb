class Cart < ActiveRecord::Base
  belongs_to  :user
  has_many    :line_items#, inverse_of: :cart

  def total
    line_items.inject(0) { |sum, item| sum + item.total_price }
  end

  def number_items_in_cart
    line_items.count
  end

  def stripe_total
    (total * 100).to_i
  end
end
