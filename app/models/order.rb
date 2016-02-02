class Order < ActiveRecord::Base
  belongs_to :order_status
  belongs_to :user
  has_many   :order_items

  before_create :set_order_status
  before_save   :update_total

  def calculate_total
    order_items.inject(0) { |sum, item| sum + item.total_price }
  end

  private

  def set_order_status
    self.order_status_id = 1
  end

  def update_total
    self.total = calculate_total
  end
end
