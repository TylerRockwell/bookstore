class Order < ActiveRecord::Base
  belongs_to :order_status
  belongs_to :user
  has_many :order_items
  
  before_save :update_total

  def calculate_total
    order_items.map{ |item| item.quanity * item.unit_price }.sum
  end

  private

  def set_order_status
    order_status_id = 1
  end

  def update_total
    total = calculate_total
  end
end
