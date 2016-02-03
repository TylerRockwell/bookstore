class Cart < ActiveRecord::Base
  belongs_to  :user
  has_many    :order_items
  before_save :update_total

  def calculate_total
    order_items.inject(0) { |sum, item| sum + item.total_price }
  end
  
  private

  def update_total
    self.total = calculate_total
  end
end
